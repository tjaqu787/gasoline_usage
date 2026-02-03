#!/usr/bin/env python3
"""
Impute missing passenger km data for Ireland (2000-2010, 2012-2024).

Method:
1. Calculate total km from fuel consumption and efficiency
2. Subtract freight km to get passenger km
"""

import sqlite3
from pathlib import Path


def impute_ireland_passenger_km(conn):
    """Impute missing passenger km for Ireland."""
    cursor = conn.cursor()

    # Get all years with fuel data
    cursor.execute("""
        SELECT year, SUM(value) as total_fuel_tj
        FROM oil_final_consumption_data
        WHERE country_code = 'ireland'
        AND product IN ('Motor gasoline', 'Gas/Diesel')
        AND year >= 2000
        GROUP BY year
        ORDER BY year
    """)
    fuel_data = {row[0]: row[1] for row in cursor.fetchall()}

    # Get efficiency benchmarks
    cursor.execute("""
        SELECT year, fleet_avg_L100
        FROM fuel_consumption_benchmarks_historical
        WHERE country_code = 'IRL'
        ORDER BY year
    """)
    efficiency_data = {row[0]: row[1] for row in cursor.fetchall()}

    # Get freight km
    cursor.execute("""
        SELECT year, AVG(km_millions) as freight_km
        FROM km_driven_data
        WHERE country_code = 'IRL'
        AND LOWER(vehicle_type) = 'freight'
        GROUP BY year
        ORDER BY year
    """)
    freight_data = {row[0]: row[1] for row in cursor.fetchall()}

    # Check which years already have passenger data
    cursor.execute("""
        SELECT year
        FROM km_driven_data
        WHERE country_code = 'IRL'
        AND LOWER(vehicle_type) = 'passenger'
    """)
    existing_passenger_years = {row[0] for row in cursor.fetchall()}

    print(f"Ireland km imputation:")
    print(f"  Fuel data: {min(fuel_data.keys())}-{max(fuel_data.keys())}")
    print(f"  Efficiency data: {min(efficiency_data.keys())}-{max(efficiency_data.keys())}")
    print(f"  Freight data: {min(freight_data.keys())}-{max(freight_data.keys())}")
    print(f"  Existing passenger data: {existing_passenger_years}")

    # Extrapolate efficiency backwards for 2000-2009
    # Use linear extrapolation from 2010-2013
    if 2010 in efficiency_data and 2013 in efficiency_data:
        eff_2010 = efficiency_data[2010]
        eff_2013 = efficiency_data[2013]
        annual_change = (eff_2013 - eff_2010) / 3  # -0.1 L/100km per year

        for year in range(2000, 2010):
            years_back = 2010 - year
            efficiency_data[year] = eff_2010 - (annual_change * years_back)

    print(f"\nExtrapolated efficiency 2000-2009:")
    for year in range(2000, 2010):
        print(f"  {year}: {efficiency_data[year]:.2f} L/100km")

    # Conversion factors
    # 1 TJ = 1e12 J
    # Gasoline: ~32 MJ/L = 32e6 J/L
    # Diesel: ~36 MJ/L = 36e6 J/L
    # Average: ~34 MJ/L = 34e6 J/L
    TJ_TO_LITERS = 1e12 / 34e6  # TJ to liters

    # Impute passenger km
    imputed_records = []

    for year in sorted(fuel_data.keys()):
        # Skip if passenger data already exists
        if year in existing_passenger_years:
            print(f"\n{year}: Passenger data exists, skipping")
            continue

        # Skip if missing any required data
        if year not in efficiency_data or year not in freight_data:
            print(f"\n{year}: Missing efficiency or freight data, skipping")
            continue

        fuel_tj = fuel_data[year]
        efficiency_L100km = efficiency_data[year]
        freight_km_millions = freight_data[year]

        # Calculate total km
        # fuel_L = fuel_TJ * TJ_TO_LITERS
        # km = fuel_L / (efficiency_L100km / 100)
        fuel_liters = fuel_tj * TJ_TO_LITERS
        total_km = fuel_liters / (efficiency_L100km / 100)
        total_km_millions = total_km / 1e6

        # Calculate passenger km
        passenger_km_millions = total_km_millions - freight_km_millions

        if passenger_km_millions < 0:
            print(f"\n{year}: Negative passenger km ({passenger_km_millions:.1f}), skipping")
            continue

        print(f"\n{year}:")
        print(f"  Fuel: {fuel_tj:.0f} TJ")
        print(f"  Efficiency: {efficiency_L100km:.2f} L/100km")
        print(f"  Total km: {total_km_millions:.1f} million km")
        print(f"  Freight km: {freight_km_millions:.1f} million km")
        print(f"  Passenger km (imputed): {passenger_km_millions:.1f} million km")

        imputed_records.append({
            'year': year,
            'passenger_km': passenger_km_millions
        })

    # Insert imputed records
    if imputed_records:
        print(f"\n\nInserting {len(imputed_records)} imputed records...")
        for record in imputed_records:
            cursor.execute("""
                INSERT INTO km_driven_data
                (country, country_code, year, vehicle_type, km_millions, unit)
                VALUES ('Ireland', 'IRL', ?, 'passenger', ?, 'MILLON_KM')
            """, (record['year'], record['passenger_km']))

        conn.commit()
        print("Done!")
    else:
        print("\nNo records to impute")

    # Summary
    cursor.execute("""
        SELECT COUNT(DISTINCT year)
        FROM km_driven_data
        WHERE country_code = 'IRL'
        AND LOWER(vehicle_type) = 'passenger'
    """)
    total_passenger_years = cursor.fetchone()[0]

    print(f"\n{'='*70}")
    print(f"Ireland now has passenger km data for {total_passenger_years} years")
    print(f"{'='*70}")


def main():
    """Main function."""
    db_path = Path('iea_oil.db')

    print(f"Opening database: {db_path}")
    conn = sqlite3.connect(db_path)

    try:
        impute_ireland_passenger_km(conn)
    finally:
        conn.close()


if __name__ == '__main__':
    main()
