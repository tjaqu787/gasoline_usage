#!/usr/bin/env python3
"""
Export forecast data from database to JSON files for web visualization.
"""

import sqlite3
import json
from pathlib import Path
from collections import defaultdict


def export_forecast_data(conn):
    """Export forecast data to JSON."""
    cursor = conn.cursor()

    # Countries to exclude (small countries with patchy data)
    excluded_countries = {'austria', 'belgium', 'greece', 'latvia', 'luxembourg', 'portugal'}

    # Get country code mapping
    cursor.execute("SELECT oecd_code, iea_code FROM country_code_mapping")
    oecd_to_iea = {row[0]: row[1] for row in cursor.fetchall()}

    # Get all forecast data
    cursor.execute("""
        SELECT
            country_code, country_name, year, efficiency_scenario,
            population, total_vehicles, ev_vehicles, ice_vehicles, ev_share,
            cars_per_capita, km_per_vehicle, fuel_efficiency_L100km,
            gasoline_demand_tj, diesel_demand_tj, total_fuel_demand_tj
        FROM forecast_data
        ORDER BY country_code, efficiency_scenario, year
    """)

    # Organize data by country and scenario
    forecast_by_country = defaultdict(lambda: {
        'country_name': None,
        'scenarios': {
            'age_out': [],
            'improvement': []
        }
    })

    for row in cursor.fetchall():
        iea_code = oecd_to_iea.get(row[0], row[0].lower())

        # Skip excluded countries
        if iea_code in excluded_countries:
            continue

        country_name = row[1]
        year = row[2]
        scenario = row[3]

        if forecast_by_country[iea_code]['country_name'] is None:
            forecast_by_country[iea_code]['country_name'] = country_name

        forecast_by_country[iea_code]['scenarios'][scenario].append({
            'year': year,
            'population': row[4],
            'total_vehicles': row[5],
            'ev_vehicles': row[6],
            'ice_vehicles': row[7],
            'ev_share': row[8],
            'cars_per_capita': row[9],
            'km_per_vehicle': row[10],
            'fuel_efficiency_L100km': row[11],
            'gasoline_demand_tj': row[12],
            'diesel_demand_tj': row[13],
            'total_fuel_demand_tj': row[14]
        })

    return dict(forecast_by_country)


def main():
    """Main function."""
    db_path = Path('iea_oil.db')
    output_dir = Path('../data')

    print(f"Opening database: {db_path}")
    conn = sqlite3.connect(db_path)

    try:
        print("Exporting forecast data...")
        forecast_data = export_forecast_data(conn)

        print(f"  Found {len(forecast_data)} countries")
        print(f"  Years: 2024-2040")

        # Write to JSON
        output_file = output_dir / 'forecast_data.json'
        with open(output_file, 'w') as f:
            json.dump(forecast_data, f, indent=2)

        print(f"\nExported to: {output_file}")
        print(f"File size: {output_file.stat().st_size / 1024:.1f} KB")

        print("\n" + "="*70)
        print("Export completed!")
        print("="*70)

    finally:
        conn.close()


if __name__ == '__main__':
    main()
