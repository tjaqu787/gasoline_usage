#!/usr/bin/env python3
"""
Export enhanced data for gasoline consumption visualization.
Includes raw data, derived features, and supports Raw Data / Efficiency / Forecast views.
"""

import sqlite3
import json
from pathlib import Path
from collections import defaultdict


def calculate_enhanced_kaya_components(conn):
    """
    Calculate enhanced Kaya identity components with separate fuel types.
    Includes: raw data (cars, pop, fuel totals, km) and derived features
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
            # Get Motor gasoline consumption in TJ
            cursor.execute("""
                SELECT value FROM oil_final_consumption_data
                WHERE country_code = ? AND year = ? AND product = 'Motor gasoline'
            """, (iea_code, year))
            gas_result = cursor.fetchone()
            gasoline_tj = gas_result[0] if gas_result else None

            # Get Diesel consumption in TJ
            cursor.execute("""
                SELECT value FROM oil_final_consumption_data
                WHERE country_code = ? AND year = ? AND product = 'Gas/Diesel'
            """, (iea_code, year))
            diesel_result = cursor.fetchone()
            diesel_tj = diesel_result[0] if diesel_result else None

            # Calculate total fuel
            fuel_total = 0
            if gasoline_tj:
                fuel_total += gasoline_tj
            if diesel_tj:
                fuel_total += diesel_tj

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

            # Get passenger km driven
            cursor.execute("""
                SELECT km_millions FROM km_driven_data
                WHERE country_code = ? AND year = ? AND vehicle_type = 'passenger'
            """, (oecd_code, year))
            pass_km_result = cursor.fetchone()
            passenger_km = (pass_km_result[0] * 1_000_000) if pass_km_result else None

            # Get freight km driven (tonne-km, different unit)
            cursor.execute("""
                SELECT km_millions FROM km_driven_data
                WHERE country_code = ? AND year = ? AND vehicle_type = 'freight'
            """, (oecd_code, year))
            freight_km_result = cursor.fetchone()
            freight_tonne_km = (freight_km_result[0] * 1_000_000) if freight_km_result else None

            # Calculate components (include even if some data is missing)
            year_data = {}

            # Raw data
            if gasoline_tj is not None:
                year_data['gasoline_tj'] = gasoline_tj
            if diesel_tj is not None:
                year_data['diesel_tj'] = diesel_tj
            if fuel_total > 0:
                year_data['fuel_total_tj'] = fuel_total
            if population is not None:
                year_data['population'] = population
            if vehicles is not None:
                year_data['vehicles'] = vehicles
            if passenger_km is not None:
                year_data['passenger_km'] = passenger_km
            if freight_tonne_km is not None:
                year_data['freight_tonne_km'] = freight_tonne_km

            # Derived features (only if we have the necessary data)
            if population and vehicles:
                year_data['cars_per_capita'] = vehicles / population

            if passenger_km and vehicles and vehicles > 0:
                year_data['km_per_vehicle'] = passenger_km / vehicles

            if fuel_total > 0 and passenger_km and passenger_km > 0:
                # Fuel efficiency in L/100km (approximate conversion: 1 TJ gasoline ≈ 26,500 liters)
                liters = fuel_total * 26_500  # TJ to liters (gasoline equivalent)
                km_in_hundreds = passenger_km / 100
                year_data['fuel_efficiency_L_per_100km'] = liters / km_in_hundreds if km_in_hundreds > 0 else None

            # Kaya components (for compatibility with existing charts)
            if all(v is not None and v > 0 for v in [fuel_total, population, vehicles, passenger_km]):
                year_data.update({
                    'pop': population,
                    'cars_per_pop': vehicles / population,
                    'km_per_veh': passenger_km / vehicles,
                    'gasoline_per_km': fuel_total / passenger_km,
                    'gasoline_total': fuel_total,
                })

            if year_data:
                kaya_data[iea_code][year] = year_data

    return dict(kaya_data)


def export_vehicle_category_data(conn):
    """
    Export vehicle category mix data (passenger vs freight).
    This will be used when category breakdown is available.
    """
    cursor = conn.cursor()

    # Get country code mapping
    cursor.execute("SELECT oecd_code, iea_code FROM country_code_mapping")
    oecd_to_iea = {row[0]: row[1] for row in cursor.fetchall()}

    category_data = defaultdict(lambda: defaultdict(dict))

    cursor.execute("""
        SELECT country_code, year, vehicle_type, km_millions, unit
        FROM km_driven_data
        WHERE km_millions IS NOT NULL
        ORDER BY country_code, year, vehicle_type
    """)

    for row in cursor.fetchall():
        oecd_code, year, vehicle_type, km_millions, unit = row
        iea_code = oecd_to_iea.get(oecd_code, oecd_code)
        category_data[iea_code][year][vehicle_type] = {
            'km_millions': km_millions,
            'unit': unit
        }

    return {
        country: {
            year: dict(categories)
            for year, categories in years.items()
        }
        for country, years in category_data.items()
    }


def export_to_json():
    """Export all enhanced data to JSON files."""
    db_path = Path('iea_oil.db')
    output_dir = Path('../data')

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

    # Export oil consumption data (all products)
    print("Exporting oil consumption data...")
    cursor.execute("""
        SELECT country_code, product, year, value
        FROM oil_final_consumption_data
        WHERE value IS NOT NULL
        AND product IN ('Motor gasoline', 'Gas/Diesel')
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

    # Calculate and export enhanced Kaya components
    print("Calculating enhanced Kaya identity components...")
    kaya_data = calculate_enhanced_kaya_components(conn)

    with open(output_dir / 'kaya_data.json', 'w') as f:
        json.dump(kaya_data, f, indent=2)

    kaya_count = sum(len(years) for years in kaya_data.values())
    kaya_countries = len(kaya_data)
    print(f"  ✓ Exported Kaya data for {kaya_countries} countries, {kaya_count} country-years")

    # Export EV stock data
    print("Exporting EV stock data...")

    # Get reverse mapping from OECD codes to IEA codes
    cursor.execute("SELECT oecd_code, iea_code FROM country_code_mapping")
    oecd_to_iea = {row[0]: row[1] for row in cursor.fetchall()}

    cursor.execute("""
        SELECT country_code, year, measure, vehicles
        FROM cars_data
        WHERE vehicles IS NOT NULL
        AND measure IN ('VEH_STOCK_TOTAL', 'VEH_STOCK_ELECTRIC', 'VEH_STOCK_HYBRID')
        ORDER BY country_code, year, measure
    """)

    ev_stock = defaultdict(lambda: defaultdict(dict))
    for row in cursor.fetchall():
        oecd_code, year, measure, value = row
        # Convert OECD code to IEA code
        iea_code = oecd_to_iea.get(oecd_code, oecd_code)
        # Use shorter measure names
        measure_name = measure.replace('VEH_STOCK_', '').lower()
        ev_stock[iea_code][year][measure_name] = value

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

    # Export vehicle category data
    print("Exporting vehicle category data...")
    category_data = export_vehicle_category_data(conn)

    with open(output_dir / 'vehicle_categories.json', 'w') as f:
        json.dump(category_data, f, indent=2)

    category_count = sum(
        len(years) * len(categories)
        for years in category_data.values()
        for categories in years.values()
    )
    category_countries = len(category_data)
    print(f"  ✓ Exported category data for {category_countries} countries, {category_count} records")

    # Export fuel consumption benchmarks
    print("Exporting fuel consumption benchmarks...")

    # Get OECD to IEA code mapping
    cursor.execute("SELECT oecd_code, iea_code FROM country_code_mapping")
    oecd_to_iea = {row[0]: row[1] for row in cursor.fetchall()}

    cursor.execute("""
        SELECT country_code, country_name, suv_L100, car_L100, region
        FROM fuel_consumption_benchmarks
        ORDER BY country_code
    """)

    fuel_benchmarks = {}
    for row in cursor.fetchall():
        oecd_code, country_name, suv_L100, car_L100, region = row
        # Convert OECD code to IEA code for consistency with countries.json
        iea_code = oecd_to_iea.get(oecd_code, oecd_code.lower())
        fuel_benchmarks[iea_code] = {
            'country_name': country_name,
            'suv_L100': suv_L100,
            'car_L100': car_L100,
            'region': region
        }

    with open(output_dir / 'fuel_benchmarks.json', 'w') as f:
        json.dump(fuel_benchmarks, f, indent=2)

    print(f"  ✓ Exported fuel benchmarks for {len(fuel_benchmarks)} countries")

    # Export historical fuel consumption benchmarks
    print("Exporting historical fuel consumption benchmarks...")
    cursor.execute("""
        SELECT country_code, country_name, year, suv_L100, car_L100, fleet_avg_L100, region, data_quality
        FROM fuel_consumption_benchmarks_historical
        ORDER BY country_code, year
    """)

    fuel_benchmarks_historical = defaultdict(lambda: defaultdict(dict))
    for row in cursor.fetchall():
        oecd_code, country_name, year, suv_L100, car_L100, fleet_avg, region, quality = row
        # Convert OECD code to IEA code for consistency
        iea_code = oecd_to_iea.get(oecd_code, oecd_code.lower())
        fuel_benchmarks_historical[iea_code][year] = {
            'country_name': country_name,
            'suv_L100': suv_L100,
            'car_L100': car_L100,
            'fleet_avg_L100': fleet_avg,
            'region': region,
            'data_quality': quality
        }

    fuel_benchmarks_historical_dict = {
        country: {
            year: dict(data)
            for year, data in years.items()
        }
        for country, years in fuel_benchmarks_historical.items()
    }

    with open(output_dir / 'fuel_benchmarks_historical.json', 'w') as f:
        json.dump(fuel_benchmarks_historical_dict, f, indent=2)

    fuel_hist_count = sum(len(years) for years in fuel_benchmarks_historical_dict.values())
    print(f"  ✓ Exported historical fuel benchmarks: {fuel_hist_count} records")

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
        'ev_records': ev_count,
        'category_countries': category_countries,
        'category_records': category_count,
        'fuel_benchmarks_countries': len(fuel_benchmarks),
        'fuel_benchmarks_historical_records': fuel_hist_count
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
    print(f"  - vehicle_categories.json ({category_countries} countries, {category_count} records)")
    print(f"  - fuel_benchmarks.json ({len(fuel_benchmarks)} countries)")
    print(f"  - fuel_benchmarks_historical.json ({fuel_hist_count} records)")
    print(f"  - summary.json")
    print("="*70)


if __name__ == '__main__':
    export_to_json()
