#!/usr/bin/env python3
"""
Create vehicle_efficiency table and import data from Excel file.

Steps:
1. Create vehicle_efficiency table
2. Calculate efficiency from existing data (fuel / km)
3. Import from Fuel_econony.xlsx "Average fuel consumption" sheet
4. Overwrite with Excel data where available
"""

import sqlite3
import csv
import subprocess
from pathlib import Path
import tempfile


def create_efficiency_table(conn):
    """Create vehicle_efficiency table."""
    cursor = conn.cursor()

    # Drop existing table
    cursor.execute("DROP TABLE IF EXISTS vehicle_efficiency")

    # Create table
    cursor.execute("""
        CREATE TABLE vehicle_efficiency (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country_code TEXT NOT NULL,
            country_name TEXT NOT NULL,
            year INTEGER NOT NULL,
            efficiency_L_per_100km REAL,
            data_source TEXT DEFAULT 'calculated',
            UNIQUE(country_code, year)
        )
    """)

    cursor.execute("CREATE INDEX idx_efficiency_country_year ON vehicle_efficiency(country_code, year)")

    conn.commit()
    print("Created vehicle_efficiency table")


def calculate_efficiency_from_data(conn):
    """
    Calculate efficiency from existing fuel consumption and km data.
    Formula: efficiency (L/100km) = (fuel_TJ / km_millions) * conversion_factor
    """
    cursor = conn.cursor()

    # Get country code mapping
    cursor.execute("SELECT iea_code, oecd_code, wb_code FROM country_code_mapping")
    mapping = {row[0]: {'oecd': row[1], 'wb': row[2]} for row in cursor.fetchall()}

    inserted_count = 0

    for iea_code, codes in mapping.items():
        oecd_code = codes['oecd']
        if not oecd_code:
            continue

        # Get years with both fuel and km data
        # Use iea_code for oil data, oecd_code for km data
        cursor.execute("""
            SELECT
                f.year,
                SUM(f.value) as total_fuel_tj,
                k.total_km
            FROM oil_final_consumption_data f
            JOIN (
                SELECT country_code, year, AVG(km_millions) as total_km
                FROM km_driven_data
                WHERE LOWER(vehicle_type) = 'passenger'
                GROUP BY country_code, year
            ) k ON k.country_code = ? AND f.year = k.year
            WHERE f.country_code = ?
            AND f.product IN ('Motor gasoline', 'Gas/Diesel')
            AND f.value IS NOT NULL
            AND k.total_km IS NOT NULL
            GROUP BY f.year
            HAVING total_fuel_tj > 0 AND k.total_km > 0
            ORDER BY f.year
        """, (oecd_code, iea_code))

        results = cursor.fetchall()

        for year, fuel_tj, km_millions in results:
            # Convert TJ to Liters
            # 1 TJ = 1e12 J
            # Gasoline: ~32 MJ/L, Diesel: ~36 MJ/L
            # Average: ~34 MJ/L = 34e6 J/L
            TJ_TO_LITERS = 1e12 / 34e6

            fuel_liters = fuel_tj * TJ_TO_LITERS
            km_total = km_millions * 1e6

            # L/100km = (liters / km) * 100
            efficiency_L_per_100km = (fuel_liters / km_total) * 100

            # Get country name
            cursor.execute("SELECT country_name FROM countries WHERE country_code = ?", (iea_code,))
            country_name_result = cursor.fetchone()
            country_name = country_name_result[0] if country_name_result else iea_code

            # Insert
            cursor.execute("""
                INSERT INTO vehicle_efficiency
                (country_code, country_name, year, efficiency_L_per_100km, data_source)
                VALUES (?, ?, ?, ?, 'calculated')
            """, (oecd_code, country_name, year, round(efficiency_L_per_100km, 2)))

            inserted_count += 1

    conn.commit()
    print(f"Calculated and inserted {inserted_count} efficiency records")


def import_excel_data(conn):
    """Import data from Excel file using libreoffice conversion."""

    excel_file = Path('oecd_data/Fuel_econony.xlsx')
    if not excel_file.exists():
        print(f"Excel file not found: {excel_file}")
        return

    # Convert specific sheet to CSV using libreoffice
    with tempfile.TemporaryDirectory() as tmpdir:
        print("Converting Excel sheet to CSV...")

        # LibreOffice command to export specific sheet
        # We'll convert the whole file then parse the right sheet
        result = subprocess.run([
            'libreoffice', '--headless', '--convert-to', 'csv',
            '--outdir', tmpdir,
            str(excel_file)
        ], capture_output=True, text=True)

        csv_file = Path(tmpdir) / 'Fuel_econony.csv'

        if not csv_file.exists():
            print("CSV conversion failed")
            return

        # Since libreoffice exports the first sheet, we need another approach
        # Let's use Python's zipfile to extract the data manually
        import_from_excel_manual(conn, excel_file)


def import_from_excel_manual(conn, excel_file):
    """Manually parse Excel XML to get 'Average fuel consumption' sheet."""
    import zipfile
    import xml.etree.ElementTree as ET

    cursor = conn.cursor()

    with zipfile.ZipFile(excel_file) as xlsx:
        # Find sheet ID for "Average fuel consumption"
        with xlsx.open('xl/workbook.xml') as f:
            tree = ET.parse(f)
            root = tree.getroot()
            rid = None
            for sheet in root.findall('.//{http://schemas.openxmlformats.org/spreadsheetml/2006/main}sheet'):
                if sheet.attrib['name'] == 'Average fuel consumption':
                    # Get rId
                    rid = sheet.attrib['{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id']
                    break

        if not rid:
            print("Could not find 'Average fuel consumption' sheet")
            return

        # Find the actual worksheet file from relationships
        with xlsx.open('xl/_rels/workbook.xml.rels') as f:
            tree = ET.parse(f)
            root = tree.getroot()
            sheet_file = None
            for rel in root.findall('.//{http://schemas.openxmlformats.org/package/2006/relationships}Relationship'):
                if rel.attrib['Id'] == rid:
                    sheet_file = 'xl/' + rel.attrib['Target']
                    break

        if not sheet_file:
            print(f"Could not find worksheet file for rId {rid}")
            return

        # Read shared strings for text values
        strings = []
        try:
            with xlsx.open('xl/sharedStrings.xml') as f:
                tree = ET.parse(f)
                for si in tree.findall('.//{http://schemas.openxmlformats.org/spreadsheetml/2006/main}si'):
                    t = si.find('.//{http://schemas.openxmlformats.org/spreadsheetml/2006/main}t')
                    strings.append(t.text if t is not None and t.text else '')
        except:
            pass

        with xlsx.open(sheet_file) as f:
            tree = ET.parse(f)
            root = tree.getroot()

            # Parse rows
            rows = []
            for row_elem in root.findall('.//{http://schemas.openxmlformats.org/spreadsheetml/2006/main}row'):
                row_data = {}
                for cell in row_elem.findall('.//{http://schemas.openxmlformats.org/spreadsheetml/2006/main}c'):
                    ref = cell.attrib['r']  # e.g., "A1"
                    col = ''.join(filter(str.isalpha, ref))

                    v = cell.find('.//{http://schemas.openxmlformats.org/spreadsheetml/2006/main}v')
                    if v is not None and v.text:
                        cell_type = cell.attrib.get('t', '')
                        if cell_type == 's':  # Shared string
                            row_data[col] = strings[int(v.text)]
                        else:
                            try:
                                row_data[col] = float(v.text)
                            except:
                                row_data[col] = v.text

                if row_data:
                    rows.append(row_data)

    # Process rows
    # Expected format: Row 1-2 are headers, Row 3 has years, Row 4+ has country data
    print(f"Found {len(rows)} rows in Excel sheet")

    # Skip first 2 header rows, row 3 (index 2) contains years
    if len(rows) < 3:
        print("Not enough rows in sheet")
        return

    year_row = rows[2]  # Third row (index 2) contains years
    years = {}
    for col, val in year_row.items():
        if col != 'A' and isinstance(val, (int, float)):
            years[col] = int(val)

    print(f"Years found: {sorted(years.values())}")

    # Process data rows (starting from row 4, index 3)
    updated_count = 0
    for row in rows[3:]:
        if 'A' not in row:
            continue

        country_name = row['A']
        if not isinstance(country_name, str):
            continue

        # Map country name to OECD code
        cursor.execute("""
            SELECT oecd_code FROM country_code_mapping
            WHERE LOWER(country_name) = LOWER(?)
        """, (country_name.strip(),))

        result = cursor.fetchone()
        if not result:
            continue

        oecd_code = result[0]

        # Process each year
        for col, year in years.items():
            if col in row and row[col] is not None:
                try:
                    efficiency = float(row[col])

                    # Update or insert
                    cursor.execute("""
                        INSERT INTO vehicle_efficiency
                        (country_code, country_name, year, efficiency_L_per_100km, data_source)
                        VALUES (?, ?, ?, ?, 'excel_import')
                        ON CONFLICT(country_code, year) DO UPDATE SET
                            efficiency_L_per_100km = excluded.efficiency_L_per_100km,
                            data_source = 'excel_import'
                    """, (oecd_code, country_name, year, round(efficiency, 2)))

                    updated_count += 1
                except (ValueError, TypeError):
                    pass

    conn.commit()
    print(f"Updated {updated_count} records from Excel data")


def main():
    """Main function."""
    db_path = Path('iea_oil.db')

    print(f"Opening database: {db_path}")
    conn = sqlite3.connect(db_path)

    try:
        # Step 1: Create table
        create_efficiency_table(conn)

        # Step 2: Calculate from existing data
        calculate_efficiency_from_data(conn)

        # Step 3: Import from Excel and overwrite
        import_excel_data(conn)

        # Summary
        cursor = conn.cursor()
        cursor.execute("SELECT COUNT(*), data_source FROM vehicle_efficiency GROUP BY data_source")
        print("\nSummary:")
        for count, source in cursor.fetchall():
            print(f"  {source}: {count} records")

        cursor.execute("SELECT MIN(year), MAX(year) FROM vehicle_efficiency")
        year_range = cursor.fetchone()
        print(f"  Year range: {year_range[0]}-{year_range[1]}")

        print("\n" + "="*70)
        print("Vehicle efficiency table created and populated!")
        print("="*70)

    finally:
        conn.close()


if __name__ == '__main__':
    main()
