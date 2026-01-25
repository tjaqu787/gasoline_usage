#!/usr/bin/env python3
"""
Load additional data for Kaya identity decomposition:
gasoline = pop × cars/pop × km/veh × gasoline/km
"""

import sqlite3
import csv
import pandas as pd
from pathlib import Path


def load_population_data(conn):
    """Load World Bank population data."""
    print("Loading population data...")

    df = pd.read_csv('population.csv')

    cursor = conn.cursor()

    # Create population table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS population_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country_name TEXT NOT NULL,
            country_code TEXT NOT NULL,
            year INTEGER NOT NULL,
            population REAL,
            UNIQUE(country_code, year)
        )
    """)

    count = 0
    # Process each row (country)
    for _, row in df.iterrows():
        country_name = row['Country Name']
        country_code = row['Country Code']

        # Process each year column
        for year in range(2000, 2025):
            year_str = str(year)
            if year_str in df.columns:
                pop_value = row[year_str]
                if pd.notna(pop_value):
                    cursor.execute("""
                        INSERT OR REPLACE INTO population_data (country_name, country_code, year, population)
                        VALUES (?, ?, ?, ?)
                    """, (country_name, country_code, year, float(pop_value)))
                    count += 1

    conn.commit()
    print(f"  ✓ Loaded {count:,} population records")
    return count


def load_cars_data(conn):
    """Load OECD cars on the road data."""
    print("Loading cars on the road data...")

    df = pd.read_csv('cars_on_the_road.csv')

    cursor = conn.cursor()

    # Create cars table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS cars_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country_code TEXT NOT NULL,
            country_name TEXT NOT NULL,
            year INTEGER NOT NULL,
            vehicles REAL,
            UNIQUE(country_code, year)
        )
    """)

    count = 0
    for _, row in df.iterrows():
        country_code = row['REF_AREA']
        country_name = row['Reference area']
        year = row['TIME_PERIOD']
        vehicles = row['OBS_VALUE']

        if pd.notna(vehicles) and pd.notna(year):
            # Vehicles are in thousands, multiply by 1000
            cursor.execute("""
                INSERT OR REPLACE INTO cars_data (country_code, country_name, year, vehicles)
                VALUES (?, ?, ?, ?)
            """, (country_code, country_name, int(year), float(vehicles) * 1000))
            count += 1

    conn.commit()
    print(f"  ✓ Loaded {count:,} vehicle records")
    return count


def load_km_driven_data(conn):
    """Load OECD road km driven data (passenger-km)."""
    print("Loading km driven data...")

    df = pd.read_csv('road_miles_driven.csv')

    cursor = conn.cursor()

    # Create km_driven table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS km_driven_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            country_code TEXT NOT NULL,
            country_name TEXT NOT NULL,
            year INTEGER NOT NULL,
            passenger_km REAL,
            UNIQUE(country_code, year)
        )
    """)

    count = 0
    for _, row in df.iterrows():
        country_code = row['REF_AREA']
        country_name = row['Reference area']
        year = row['TIME_PERIOD']
        passenger_km = row['OBS_VALUE']

        if pd.notna(passenger_km) and pd.notna(year):
            # Values are in millions of km, multiply by 1,000,000
            cursor.execute("""
                INSERT OR REPLACE INTO km_driven_data (country_code, country_name, year, passenger_km)
                VALUES (?, ?, ?, ?)
            """, (country_code, country_name, int(year), float(passenger_km) * 1_000_000))
            count += 1

    conn.commit()
    print(f"  ✓ Loaded {count:,} km driven records")
    return count


def create_country_code_mapping(conn):
    """Create mapping between different country code systems."""
    print("Creating country code mapping...")

    cursor = conn.cursor()

    # Create mapping table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS country_code_mapping (
            iea_code TEXT PRIMARY KEY,
            oecd_code TEXT,
            wb_code TEXT,
            country_name TEXT
        )
    """)

    # Manual mapping for OECD countries
    mapping = {
        'australia': {'oecd': 'AUS', 'wb': 'AUS', 'name': 'Australia'},
        'austria': {'oecd': 'AUT', 'wb': 'AUT', 'name': 'Austria'},
        'belgium': {'oecd': 'BEL', 'wb': 'BEL', 'name': 'Belgium'},
        'brazil': {'oecd': 'BRA', 'wb': 'BRA', 'name': 'Brazil'},
        'canada': {'oecd': 'CAN', 'wb': 'CAN', 'name': 'Canada'},
        'denmark': {'oecd': 'DNK', 'wb': 'DNK', 'name': 'Denmark'},
        'finland': {'oecd': 'FIN', 'wb': 'FIN', 'name': 'Finland'},
        'germany': {'oecd': 'DEU', 'wb': 'DEU', 'name': 'Germany'},
        'greece': {'oecd': 'GRC', 'wb': 'GRC', 'name': 'Greece'},
        'iceland': {'oecd': 'ISL', 'wb': 'ISL', 'name': 'Iceland'},
        'ireland': {'oecd': 'IRL', 'wb': 'IRL', 'name': 'Ireland'},
        'italy': {'oecd': 'ITA', 'wb': 'ITA', 'name': 'Italy'},
        'japan': {'oecd': 'JPN', 'wb': 'JPN', 'name': 'Japan'},
        'korea': {'oecd': 'KOR', 'wb': 'KOR', 'name': 'Korea'},
        'latvia': {'oecd': 'LVA', 'wb': 'LVA', 'name': 'Latvia'},
        'luxembourg': {'oecd': 'LUX', 'wb': 'LUX', 'name': 'Luxembourg'},
        'netherlands': {'oecd': 'NLD', 'wb': 'NLD', 'name': 'Netherlands'},
        'new-zealand': {'oecd': 'NZL', 'wb': 'NZL', 'name': 'New Zealand'},
        'norway': {'oecd': 'NOR', 'wb': 'NOR', 'name': 'Norway'},
        'portugal': {'oecd': 'PRT', 'wb': 'PRT', 'name': 'Portugal'},
        'slovenia': {'oecd': 'SVN', 'wb': 'SVN', 'name': 'Slovenia'},
        'spain': {'oecd': 'ESP', 'wb': 'ESP', 'name': 'Spain'},
        'sweden': {'oecd': 'SWE', 'wb': 'SWE', 'name': 'Sweden'},
        'switzerland': {'oecd': 'CHE', 'wb': 'CHE', 'name': 'Switzerland'},
        'turkiye': {'oecd': 'TUR', 'wb': 'TUR', 'name': 'Türkiye'},
        'united-kingdom': {'oecd': 'GBR', 'wb': 'GBR', 'name': 'United Kingdom'},
        'united-states': {'oecd': 'USA', 'wb': 'USA', 'name': 'United States'}
    }

    for iea_code, codes in mapping.items():
        cursor.execute("""
            INSERT OR REPLACE INTO country_code_mapping (iea_code, oecd_code, wb_code, country_name)
            VALUES (?, ?, ?, ?)
        """, (iea_code, codes['oecd'], codes['wb'], codes['name']))

    conn.commit()
    print(f"  ✓ Created mapping for {len(mapping)} countries")


def main():
    """Main function."""
    db_path = Path('iea_oil.db')

    print(f"Opening database: {db_path}")
    conn = sqlite3.connect(db_path)

    try:
        # Create country code mapping first
        create_country_code_mapping(conn)

        # Load all data
        pop_count = load_population_data(conn)
        cars_count = load_cars_data(conn)
        km_count = load_km_driven_data(conn)

        # Create index for faster queries
        cursor = conn.cursor()
        cursor.execute("CREATE INDEX IF NOT EXISTS idx_pop_country_year ON population_data(country_code, year)")
        cursor.execute("CREATE INDEX IF NOT EXISTS idx_cars_country_year ON cars_data(country_code, year)")
        cursor.execute("CREATE INDEX IF NOT EXISTS idx_km_country_year ON km_driven_data(country_code, year)")
        conn.commit()

        print(f"\n{'='*70}")
        print("Data loading completed!")
        print(f"{'='*70}")
        print(f"Total records loaded:")
        print(f"  Population: {pop_count:,}")
        print(f"  Vehicles: {cars_count:,}")
        print(f"  Km driven: {km_count:,}")
        print(f"{'='*70}")

    finally:
        conn.close()


if __name__ == '__main__':
    main()
