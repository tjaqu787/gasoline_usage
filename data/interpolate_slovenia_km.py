#!/usr/bin/env python3
"""
Linear interpolation for missing Slovenia passenger km data (2011-2015).
"""

import sqlite3
from pathlib import Path


def interpolate_slovenia_passenger_km(conn):
    """Interpolate missing passenger km for Slovenia."""
    cursor = conn.cursor()

    # Get existing passenger data
    cursor.execute("""
        SELECT year, AVG(km_millions) as passenger_km
        FROM km_driven_data
        WHERE country_code = 'SVN'
        AND LOWER(vehicle_type) = 'passenger'
        GROUP BY year
        ORDER BY year
    """)

    existing_data = {row[0]: row[1] for row in cursor.fetchall()}

    print("Slovenia passenger km data:")
    print(f"  Existing years: {sorted(existing_data.keys())}")

    # Identify gaps
    min_year = min(existing_data.keys())
    max_year = max(existing_data.keys())

    missing_years = []
    for year in range(min_year, max_year + 1):
        if year not in existing_data:
            missing_years.append(year)

    print(f"  Missing years: {missing_years}")

    if not missing_years:
        print("\nNo missing years to interpolate!")
        return

    # For each missing year, find nearest surrounding years
    interpolated_records = []

    for year in missing_years:
        # Find previous year with data
        prev_year = year - 1
        while prev_year >= min_year and prev_year not in existing_data:
            prev_year -= 1

        # Find next year with data
        next_year = year + 1
        while next_year <= max_year and next_year not in existing_data:
            next_year += 1

        if prev_year in existing_data and next_year in existing_data:
            prev_km = existing_data[prev_year]
            next_km = existing_data[next_year]

            # Linear interpolation
            gap = next_year - prev_year
            weight = (year - prev_year) / gap
            interpolated_km = prev_km + (next_km - prev_km) * weight

            print(f"\n{year}:")
            print(f"  Interpolating between {prev_year} ({prev_km:.1f}) and {next_year} ({next_km:.1f})")
            print(f"  Weight: {weight:.3f}")
            print(f"  Interpolated: {interpolated_km:.1f} million km")

            interpolated_records.append({
                'year': year,
                'passenger_km': interpolated_km
            })

    # Insert interpolated records
    if interpolated_records:
        print(f"\n\nInserting {len(interpolated_records)} interpolated records...")
        for record in interpolated_records:
            cursor.execute("""
                INSERT INTO km_driven_data
                (country, country_code, year, vehicle_type, km_millions, unit)
                VALUES ('Slovenia', 'SVN', ?, 'passenger', ?, 'MILLON_KM')
            """, (record['year'], record['passenger_km']))

        conn.commit()
        print("Done!")

    # Summary
    cursor.execute("""
        SELECT COUNT(DISTINCT year)
        FROM km_driven_data
        WHERE country_code = 'SVN'
        AND LOWER(vehicle_type) = 'passenger'
    """)
    total_passenger_years = cursor.fetchone()[0]

    print(f"\n{'='*70}")
    print(f"Slovenia now has passenger km data for {total_passenger_years} years")
    print(f"{'='*70}")


def main():
    """Main function."""
    db_path = Path('iea_oil.db')

    print(f"Opening database: {db_path}")
    conn = sqlite3.connect(db_path)

    try:
        interpolate_slovenia_passenger_km(conn)
    finally:
        conn.close()


if __name__ == '__main__':
    main()
