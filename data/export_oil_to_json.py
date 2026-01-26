#!/usr/bin/env python3
"""
Export oil data from SQLite database to JSON files for web visualization.
"""

import sqlite3
import json
from pathlib import Path
from collections import defaultdict


def export_to_json():
    """Export database to JSON files."""
    db_path = Path('data/iea_oil.db')
    output_dir = Path('data')
    output_dir.mkdir(exist_ok=True)

    print("Connecting to database...")
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Export countries
    print("Exporting countries...")
    cursor.execute("SELECT country_code, country_name FROM countries ORDER BY country_code")
    countries = {}
    for row in cursor.fetchall():
        countries[row[0]] = row[1]

    with open(output_dir / 'countries.json', 'w') as f:
        json.dump(countries, f, indent=2)
    print(f"  ✓ Exported {len(countries)} countries")

    # Export oil consumption data
    print("Exporting oil consumption data...")
    cursor.execute("""
        SELECT country_code, product, year, value
        FROM oil_final_consumption_data
        WHERE value IS NOT NULL
        ORDER BY country_code, year, product
    """)

    oil_consumption = defaultdict(lambda: defaultdict(dict))
    for row in cursor.fetchall():
        country_code, product, year, value = row
        oil_consumption[country_code][year][product] = value

    # Convert defaultdict to regular dict for JSON serialization
    oil_consumption_dict = {
        country: {
            year: dict(products)
            for year, products in years.items()
        }
        for country, years in oil_consumption.items()
    }

    with open(output_dir / 'oil_consumption.json', 'w') as f:
        json.dump(oil_consumption_dict, f, indent=2)

    total_records = sum(
        len(years) * len(products)
        for years in oil_consumption_dict.values()
        for products in years.values()
    )
    print(f"  ✓ Exported {total_records:,} oil consumption records")

    # Create summary with years and products
    print("Creating summary...")
    cursor.execute("SELECT DISTINCT year FROM oil_final_consumption_data ORDER BY year")
    years = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT DISTINCT product FROM oil_final_consumption_data ORDER BY product")
    products = [row[0] for row in cursor.fetchall()]

    summary = {
        'years': years,
        'products': products,
        'total_countries': len(countries),
        'total_records': total_records
    }

    with open(output_dir / 'summary.json', 'w') as f:
        json.dump(summary, f, indent=2)
    print(f"  ✓ Created summary (years: {len(years)}, products: {len(products)})")

    conn.close()

    print("\n" + "="*70)
    print("Export completed!")
    print("="*70)
    print(f"Files created in: {output_dir.absolute()}")
    print(f"  - countries.json ({len(countries)} countries)")
    print(f"  - oil_consumption.json ({total_records:,} records)")
    print(f"  - summary.json")
    print("="*70)


if __name__ == '__main__':
    export_to_json()
