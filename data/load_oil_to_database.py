#!/usr/bin/env python3
"""
Load IEA scraped oil data into a SQLite database.

Database schema:
- countries: country metadata
- oil_final_consumption_data: oil final consumption by product over time
"""

import sqlite3
import csv
from pathlib import Path
from datetime import datetime


def create_database(db_path):
    """Create database and tables."""
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Countries table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS countries (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country_code TEXT UNIQUE NOT NULL,
            country_name TEXT,
            has_oil_data BOOLEAN DEFAULT 0,
            last_updated TIMESTAMP
        )
    """)

    # Oil final consumption data table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS oil_final_consumption_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country_code TEXT NOT NULL,
            product TEXT NOT NULL,
            year INTEGER NOT NULL,
            value REAL,
            units TEXT,
            FOREIGN KEY (country_code) REFERENCES countries(country_code),
            UNIQUE(country_code, product, year)
        )
    """)

    # Create indexes for faster queries
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_oil_country_year ON oil_final_consumption_data(country_code, year)")
    cursor.execute("CREATE INDEX IF NOT EXISTS idx_oil_product ON oil_final_consumption_data(product)")

    conn.commit()
    return conn


def parse_csv_file(filepath):
    """
    Parse a CSV file and extract data.
    Returns: list of dicts with keys: product, year, value, units
    """
    data = []

    with open(filepath, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        rows = list(reader)

        if len(rows) < 2:
            return data  # Empty or header-only file

        # First row is header
        header = rows[0]

        # Data starts from row 2
        for row in rows[1:]:
            if len(row) < 4:
                continue

            # Parse row: [product, value, year, units]
            product = row[0].strip(' "')
            try:
                value = float(row[1]) if row[1].strip() else None
            except (ValueError, IndexError):
                value = None

            try:
                year = int(row[2]) if row[2].strip() else None
            except (ValueError, IndexError):
                year = None

            units = row[3].strip() if len(row) > 3 else ''

            # Skip rows with missing critical data
            if not product or year is None:
                continue

            data.append({
                'product': product,
                'year': year,
                'value': value,
                'units': units
            })

    return data


def insert_country(conn, country_code, country_name=None):
    """Insert or update country record."""
    cursor = conn.cursor()

    cursor.execute("""
        INSERT OR IGNORE INTO countries (country_code, country_name, last_updated)
        VALUES (?, ?, ?)
    """, (country_code, country_name or country_code.replace('-', ' ').title(), datetime.now()))

    conn.commit()


def update_country_flags(conn, country_code, has_oil=False):
    """Update country data availability flags."""
    cursor = conn.cursor()

    if has_oil:
        cursor.execute("UPDATE countries SET has_oil_data = 1 WHERE country_code = ?", (country_code,))

    conn.commit()


def load_oil_data(conn, country_code, filepath):
    """Load oil final consumption data from CSV."""
    data = parse_csv_file(filepath)

    if not data:
        return 0

    cursor = conn.cursor()
    count = 0

    for row in data:
        try:
            cursor.execute("""
                INSERT OR REPLACE INTO oil_final_consumption_data (country_code, product, year, value, units)
                VALUES (?, ?, ?, ?, ?)
            """, (country_code, row['product'], row['year'], row['value'], row['units']))
            count += 1
        except sqlite3.Error as e:
            print(f"    Error inserting oil data: {e}")

    conn.commit()
    return count


def main():
    """Main function to load all data into database."""
    # Paths
    data_dir = Path('iea_oil_scraped')
    db_path = Path('iea_oil.db')

    print("Creating database...")
    conn = create_database(db_path)

    # Get all country directories
    country_dirs = sorted([d for d in data_dir.iterdir() if d.is_dir()])

    print(f"Found {len(country_dirs)} countries to process\n")

    stats = {
        'total_countries': 0,
        'countries_with_oil_data': 0,
        'total_oil_rows': 0
    }

    for country_dir in country_dirs:
        country_code = country_dir.name
        stats['total_countries'] += 1

        print(f"[{stats['total_countries']}/{len(country_dirs)}] Processing {country_code}...")

        # Insert country
        insert_country(conn, country_code)

        has_oil = False

        # Load oil final consumption data
        oil_file = country_dir / 'oil_final_consumption.csv'
        if oil_file.exists():
            count = load_oil_data(conn, country_code, oil_file)
            if count > 0:
                print(f"    ✓ Loaded {count} oil consumption records")
                stats['total_oil_rows'] += count
                stats['countries_with_oil_data'] += 1
                has_oil = True
        else:
            print(f"    ⚠ No oil data file found")

        # Update country flags
        update_country_flags(conn, country_code, has_oil)

    conn.close()

    # Print summary
    print(f"\n{'='*70}")
    print("Database loading completed!")
    print(f"{'='*70}")
    print(f"Database saved to: {db_path}")
    print(f"\nStatistics:")
    print(f"  Total countries: {stats['total_countries']}")
    print(f"  Countries with oil data: {stats['countries_with_oil_data']}")
    print(f"  Total oil consumption records: {stats['total_oil_rows']:,}")
    print(f"{'='*70}")

    # Show database size
    db_size = db_path.stat().st_size / (1024 * 1024)
    print(f"\nDatabase size: {db_size:.2f} MB")

    # Show sample query
    print(f"\nSample query results:")
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Show available products
    cursor.execute("SELECT DISTINCT product FROM oil_final_consumption_data ORDER BY product")
    products = [row[0] for row in cursor.fetchall()]
    print(f"\nAvailable oil products ({len(products)}):")
    for product in products:
        print(f"  - {product}")

    # Show sample data for one country
    cursor.execute("""
        SELECT country_code, product, year, value, units
        FROM oil_final_consumption_data
        WHERE country_code = 'canada' AND product = 'Motor gasoline' AND value IS NOT NULL
        ORDER BY year DESC
        LIMIT 5
    """)
    print(f"\nSample data - Canada Motor gasoline (most recent 5 years):")
    for row in cursor.fetchall():
        print(f"  {row[2]}: {row[3]:,.0f} {row[4]}")

    conn.close()


if __name__ == '__main__':
    main()
