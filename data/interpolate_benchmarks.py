#!/usr/bin/env python3
"""
Interpolate missing years in fuel_consumption_benchmarks_historical table.
"""

import sqlite3
from pathlib import Path


def interpolate_benchmarks(conn):
    """Interpolate missing years for each country's benchmark data."""
    cursor = conn.cursor()

    # Get all countries with their data
    cursor.execute("""
        SELECT DISTINCT country_code
        FROM fuel_consumption_benchmarks_historical
        ORDER BY country_code
    """)
    countries = [row[0] for row in cursor.fetchall()]

    print(f"Processing {len(countries)} countries...")

    total_inserted = 0

    for country_code in countries:
        # Get all existing data for this country
        cursor.execute("""
            SELECT year, country_name, suv_L100, car_L100, fleet_avg_L100, region, data_quality, source_notes
            FROM fuel_consumption_benchmarks_historical
            WHERE country_code = ?
            ORDER BY year
        """, (country_code,))

        rows = cursor.fetchall()
        if len(rows) < 2:
            print(f"  {country_code}: Skipping (less than 2 data points)")
            continue

        # Get min and max year
        min_year = rows[0][0]
        max_year = rows[-1][0]

        # Create a dict of existing data
        existing_data = {row[0]: row for row in rows}

        # Get country name and region from first row
        country_name = rows[0][1]
        region = rows[0][5]

        # Find missing years and interpolate
        inserted_count = 0
        for year in range(min_year, max_year + 1):
            if year not in existing_data:
                # Find the surrounding years
                prev_year = year - 1
                next_year = year + 1

                # Find closest previous year with data
                while prev_year >= min_year and prev_year not in existing_data:
                    prev_year -= 1

                # Find closest next year with data
                while next_year <= max_year and next_year not in existing_data:
                    next_year += 1

                if prev_year in existing_data and next_year in existing_data:
                    prev_data = existing_data[prev_year]
                    next_data = existing_data[next_year]

                    # Calculate interpolation weight
                    total_gap = next_year - prev_year
                    weight = (year - prev_year) / total_gap

                    # Interpolate SUV
                    suv_L100 = prev_data[2] + (next_data[2] - prev_data[2]) * weight

                    # Interpolate car
                    car_L100 = prev_data[3] + (next_data[3] - prev_data[3]) * weight

                    # Interpolate fleet_avg if both values exist
                    if prev_data[4] is not None and next_data[4] is not None:
                        fleet_avg_L100 = prev_data[4] + (next_data[4] - prev_data[4]) * weight
                    else:
                        fleet_avg_L100 = None

                    # Insert interpolated data
                    cursor.execute("""
                        INSERT OR REPLACE INTO fuel_consumption_benchmarks_historical
                        (country_code, country_name, year, suv_L100, car_L100, fleet_avg_L100, region, data_quality, source_notes)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """, (
                        country_code,
                        country_name,
                        year,
                        round(suv_L100, 2),
                        round(car_L100, 2),
                        round(fleet_avg_L100, 2) if fleet_avg_L100 is not None else None,
                        region,
                        'interpolated',
                        f'Linear interpolation between {prev_year} and {next_year}'
                    ))

                    inserted_count += 1

        if inserted_count > 0:
            print(f"  {country_code}: Interpolated {inserted_count} years ({min_year}-{max_year})")
            total_inserted += inserted_count

    conn.commit()
    print(f"\nTotal interpolated records inserted: {total_inserted}")

    # Show summary
    cursor.execute("""
        SELECT
            data_quality,
            COUNT(*) as count
        FROM fuel_consumption_benchmarks_historical
        GROUP BY data_quality
        ORDER BY data_quality
    """)

    print("\nData quality summary:")
    for row in cursor.fetchall():
        print(f"  {row[0]}: {row[1]} records")


def main():
    """Main function."""
    db_path = Path('iea_oil.db')

    print(f"Opening database: {db_path}")
    conn = sqlite3.connect(db_path)

    try:
        interpolate_benchmarks(conn)
        print("\n" + "="*70)
        print("Interpolation completed!")
        print("="*70)

    finally:
        conn.close()


if __name__ == '__main__':
    main()
