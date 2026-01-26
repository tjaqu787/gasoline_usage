#!/usr/bin/env python3
"""
Export Kaya identity decomposition data to JSON.
gasoline = pop × cars/pop × km/veh × gasoline/km
"""

import sqlite3
import json
from pathlib import Path
from collections import defaultdict


def calculate_kaya_components(conn):
    """
    Calculate Kaya identity components for each country and year.
    gasoline = pop × cars/pop × km/veh × gasoline/km
    """
    cursor = conn.cursor()

    # Get country code mapping
    cursor.execute("SELECT iea_code, oecd_code, wb_code FROM country_code_mapping")
    mapping = {row[0]: {'oecd': row[1], 'wb': row[2]} for row in cursor.fetchall()}

    kaya_data = defaultdict(dict)

    for iea_code, codes in mapping.items():
        oecd_code = codes['oecd']
        wb_code = codes['wb']

        # Get all years with data
        cursor.execute("""
            SELECT DISTINCT year FROM oil_final_consumption_data
            WHERE country_code = ?
            ORDER BY year
        """, (iea_code,))

        years = [row[0] for row in cursor.fetchall()]

        for year in years:
            # Get gasoline consumption (Motor gasoline + Gas/Diesel) in TJ
            cursor.execute("""
                SELECT product, value FROM oil_final_consumption_data
                WHERE country_code = ? AND year = ?
                AND product IN ('Motor gasoline', 'Gas/Diesel')
            """, (iea_code, year))

            gasoline_total = sum(row[1] for row in cursor.fetchall() if row[1] is not None)

            # Get population
            cursor.execute("""
                SELECT population FROM population_data
                WHERE country_code = ? AND year = ?
            """, (wb_code, year))
            pop_result = cursor.fetchone()
            population = pop_result[0] if pop_result else None

            # Get vehicles (total fleet)
            cursor.execute("""
                SELECT vehicles FROM cars_data
                WHERE country_code = ? AND year = ? AND measure = 'VEH_STOCK_TOTAL'
            """, (oecd_code, year))
            veh_result = cursor.fetchone()
            vehicles = veh_result[0] if veh_result else None

            # Get km driven (passenger-km)
            cursor.execute("""
                SELECT passenger_km FROM km_driven_data
                WHERE country_code = ? AND year = ?
            """, (oecd_code, year))
            km_result = cursor.fetchone()
            km_total = km_result[0] if km_result else None

            # Calculate Kaya components only if all data available
            if all(v is not None and v > 0 for v in [gasoline_total, population, vehicles, km_total]):
                kaya_data[iea_code][year] = {
                    # Raw values
                    'gasoline_total': gasoline_total,  # TJ
                    'population': population,
                    'vehicles': vehicles,
                    'km_total': km_total,

                    # Kaya components
                    'pop': population,
                    'cars_per_pop': vehicles / population,  # vehicles per person
                    'km_per_veh': km_total / vehicles,  # km per vehicle per year
                    'gasoline_per_km': gasoline_total / km_total,  # TJ per km

                    # Verify: product should equal gasoline_total
                    'kaya_product': population * (vehicles / population) * (km_total / vehicles) * (gasoline_total / km_total)
                }

    return dict(kaya_data)


def export_to_json():
    """Export all data to JSON files."""
    db_path = Path('data/iea_oil.db')
    output_dir = Path('data')

    print("Connecting to database...")
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()

    # Export countries (same as before)
    print("Exporting countries...")
    cursor.execute("SELECT country_code, country_name FROM countries ORDER BY country_code")
    countries = {}
    for row in cursor.fetchall():
        countries[row[0]] = row[1]

    with open(output_dir / 'countries.json', 'w') as f:
        json.dump(countries, f, indent=2)
    print(f"  ✓ Exported {len(countries)} countries")

    # Export oil consumption data (filtered to specific products)
    print("Exporting oil consumption data...")
    cursor.execute("""
        SELECT country_code, product, year, value
        FROM oil_final_consumption_data
        WHERE value IS NOT NULL
        AND product IN ('Gas/Diesel', 'Jet kerosene', 'Motor gasoline')
        ORDER BY country_code, year, product
    """)

    oil_consumption = defaultdict(lambda: defaultdict(dict))
    for row in cursor.fetchall():
        country_code, product, year, value = row
        oil_consumption[country_code][year][product] = value

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

    # Calculate and export Kaya components
    print("Calculating Kaya identity components...")
    kaya_data = calculate_kaya_components(conn)

    with open(output_dir / 'kaya_data.json', 'w') as f:
        json.dump(kaya_data, f, indent=2)

    kaya_count = sum(len(years) for years in kaya_data.values())
    kaya_countries = len(kaya_data)
    print(f"  ✓ Exported Kaya data for {kaya_countries} countries, {kaya_count} country-years")

    # Export EV stock data
    print("Exporting EV stock data...")
    cursor.execute("""
        SELECT country_code, year, measure, vehicles
        FROM cars_data
        WHERE vehicles IS NOT NULL
        AND measure IN ('VEH_STOCK_TOTAL', 'VEH_STOCK_ELECTRIC', 'VEH_STOCK_HYBRID')
        ORDER BY country_code, year, measure
    """)

    ev_stock = defaultdict(lambda: defaultdict(dict))
    for row in cursor.fetchall():
        country_code, year, measure, value = row
        # Use shorter measure names
        measure_name = measure.replace('VEH_STOCK_', '').lower()
        ev_stock[country_code][year][measure_name] = value

    ev_stock_dict = {
        country: {
            year: dict(measures)
            for year, measures in years.items()
        }
        for country, years in ev_stock.items()
    }

    with open(output_dir / 'ev_stock.json', 'w') as f:
        json.dump(ev_stock_dict, f, indent=2)

    ev_count = sum(
        len(years) * len(measures)
        for years in ev_stock_dict.values()
        for measures in years.values()
    )
    ev_countries = len(ev_stock_dict)
    print(f"  ✓ Exported EV stock data for {ev_countries} countries, {ev_count} records")

    # Create summary
    print("Creating summary...")
    cursor.execute("SELECT DISTINCT year FROM oil_final_consumption_data ORDER BY year")
    years = [row[0] for row in cursor.fetchall()]

    cursor.execute("SELECT DISTINCT product FROM oil_final_consumption_data ORDER BY product")
    products = [row[0] for row in cursor.fetchall()]

    summary = {
        'years': years,
        'products': products,
        'total_countries': len(countries),
        'total_records': total_records,
        'kaya_countries': kaya_countries,
        'kaya_records': kaya_count,
        'ev_countries': ev_countries,
        'ev_records': ev_count
    }

    with open(output_dir / 'summary.json', 'w') as f:
        json.dump(summary, f, indent=2)
    print(f"  ✓ Created summary")

    conn.close()

    print("\n" + "="*70)
    print("Export completed!")
    print("="*70)
    print(f"Files created in: {output_dir.absolute()}")
    print(f"  - countries.json ({len(countries)} countries)")
    print(f"  - oil_consumption.json ({total_records:,} records)")
    print(f"  - kaya_data.json ({kaya_countries} countries, {kaya_count} country-years)")
    print(f"  - ev_stock.json ({ev_countries} countries, {ev_count} records)")
    print(f"  - summary.json")
    print("="*70)


if __name__ == '__main__':
    export_to_json()
