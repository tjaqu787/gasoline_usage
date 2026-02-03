#!/usr/bin/env python3
"""
Build forecast models for gasoline demand - Version 2.

Forecast components:
1. Population growth - extrapolate from past 10 years
2. EV adoption - sigmoid curve reaching 80% saturation for passenger vehicles
3. Fuel efficiency - two scenarios:
   a. "age_out": Fleet ages out to current benchmark (constant)
   b. "improvement": Follow USA log-diff trend or converge to USA
4. Car ownership - converge to 0.5 cars per capita
"""

import sqlite3
import numpy as np
from pathlib import Path


def sigmoid(x, L, k, x0):
    """
    Sigmoid function for EV adoption curve.
    L: maximum value (saturation level, e.g., 0.8 for 80%)
    k: steepness
    x0: midpoint year
    """
    return L / (1 + np.exp(-k * (x - x0)))


def calculate_growth_rate(values, years):
    """Calculate compound annual growth rate."""
    if len(values) < 2 or values[0] == 0:
        return 0.0

    n = years[-1] - years[0]
    if n == 0:
        return 0.0

    rate = (values[-1] / values[0]) ** (1/n) - 1
    return rate


def calculate_log_diff_rate(values, years):
    """
    Calculate log difference rate (percent change per year).
    This is better for efficiency which asymptotically approaches a limit.
    """
    if len(values) < 2 or any(v <= 0 for v in values):
        return 0.0

    # Take log of values
    log_values = np.log(values)

    # Linear regression on log values
    x = np.array(years) - years[0]
    coeffs = np.polyfit(x, log_values, 1)

    # Return the slope (log-diff rate)
    return coeffs[0]


def converge_to_target(current, target, years_ahead, total_years=16):
    """
    Converge current value to target over total_years.
    Uses exponential convergence: value = target + (current - target) * exp(-rate * years_ahead)
    """
    if years_ahead >= total_years:
        return target

    # Exponential decay rate (reaches ~95% of target in total_years)
    rate = 3.0 / total_years
    return target + (current - target) * np.exp(-rate * years_ahead)


def build_forecast_tables(conn):
    """Create forecast tables."""
    cursor = conn.cursor()

    # Drop existing tables
    cursor.execute("DROP TABLE IF EXISTS forecast_data")
    cursor.execute("DROP VIEW IF EXISTS forecast_summary")

    # Create forecast table with efficiency_scenario field
    cursor.execute("""
        CREATE TABLE forecast_data (
            country_code TEXT NOT NULL,
            country_name TEXT NOT NULL,
            year INTEGER NOT NULL,
            efficiency_scenario TEXT NOT NULL,
            population REAL,
            total_vehicles REAL,
            ev_vehicles REAL,
            ice_vehicles REAL,
            ev_share REAL,
            cars_per_capita REAL,
            km_per_vehicle REAL,
            fuel_efficiency_L100km REAL,
            gasoline_demand_tj REAL,
            diesel_demand_tj REAL,
            total_fuel_demand_tj REAL,
            UNIQUE(country_code, year, efficiency_scenario)
        )
    """)

    conn.commit()
    print("Forecast tables created")


def get_historical_data(cursor, country_code, oecd_code, wb_code):
    """Get historical data for a country."""

    # Get population data (last 10 years)
    cursor.execute("""
        SELECT year, population
        FROM population_data
        WHERE country_code = ?
        AND year >= 2013
        ORDER BY year
    """, (wb_code,))
    pop_data = cursor.fetchall()

    # Get vehicle data (last 10 years)
    cursor.execute("""
        SELECT year, MAX(vehicles) as total_vehicles
        FROM cars_data
        WHERE country_code = ?
        AND measure = 'VEH_STOCK_TOTAL'
        AND year >= 2013
        GROUP BY year
        ORDER BY year
    """, (oecd_code,))
    vehicle_data = cursor.fetchall()

    # Get EV data
    cursor.execute("""
        SELECT year, vehicles
        FROM cars_data
        WHERE country_code = ?
        AND measure = 'VEH_STOCK_EV'
        AND year >= 2013
        ORDER BY year
    """, (oecd_code,))
    ev_data = {row[0]: row[1] for row in cursor.fetchall()}

    # Get fuel consumption (Motor gasoline + Gas/Diesel)
    cursor.execute("""
        SELECT year,
               SUM(CASE WHEN product = 'Motor gasoline' THEN value ELSE 0 END) as gasoline_tj,
               SUM(CASE WHEN product = 'Gas/Diesel' THEN value ELSE 0 END) as diesel_tj
        FROM oil_final_consumption_data
        WHERE country_code = ?
        AND product IN ('Motor gasoline', 'Gas/Diesel')
        AND year >= 2013
        GROUP BY year
        ORDER BY year
    """, (country_code,))
    fuel_data = cursor.fetchall()

    # Get km driven
    cursor.execute("""
        SELECT year, SUM(km_millions) as total_km
        FROM km_driven_data
        WHERE country_code = ?
        AND vehicle_type = 'passenger'
        AND year >= 2013
        GROUP BY year
        ORDER BY year
    """, (oecd_code,))
    km_data = cursor.fetchall()

    # Get fuel efficiency benchmarks (all available data)
    cursor.execute("""
        SELECT year, fleet_avg_L100
        FROM fuel_consumption_benchmarks_historical
        WHERE country_code = ?
        ORDER BY year
    """, (oecd_code,))
    efficiency_data = cursor.fetchall()

    return {
        'population': pop_data,
        'vehicles': vehicle_data,
        'ev': ev_data,
        'fuel': fuel_data,
        'km': km_data,
        'efficiency': efficiency_data
    }


def forecast_country(cursor, country_code, oecd_code, wb_code, country_name, forecast_years, usa_log_diff_rate, usa_current_efficiency):
    """Generate forecast for a single country."""

    # Get historical data
    hist = get_historical_data(cursor, country_code, oecd_code, wb_code)

    if not hist['population'] or not hist['vehicles']:
        print(f"  {country_code}: Insufficient data, skipping")
        return []

    # Base year (most recent year with data)
    base_year = hist['population'][-1][0]
    base_population = hist['population'][-1][1]
    base_vehicles = hist['vehicles'][-1][1] if hist['vehicles'] else 0
    base_ev = hist['ev'].get(base_year, 0)
    base_ev_share = base_ev / base_vehicles if base_vehicles > 0 else 0

    # Calculate population growth rate
    pop_years = [row[0] for row in hist['population']]
    pop_values = [row[1] for row in hist['population']]
    pop_growth_rate = calculate_growth_rate(pop_values, pop_years)

    # Car ownership - will converge to 0.5 cars per capita
    vehicle_years = [row[0] for row in hist['vehicles']]
    vehicle_values = [row[1] for row in hist['vehicles']]

    cars_per_capita_values = []
    for year in vehicle_years:
        pop_idx = pop_years.index(year) if year in pop_years else None
        if pop_idx is not None:
            cars_per_capita = vehicle_values[vehicle_years.index(year)] / pop_values[pop_idx]
            cars_per_capita_values.append(cars_per_capita)

    base_cars_per_capita = cars_per_capita_values[-1] if cars_per_capita_values else 0.4
    target_cars_per_capita = 0.5

    # Fuel efficiency analysis
    if hist['efficiency']:
        efficiency_years = [row[0] for row in hist['efficiency'] if row[1] is not None]
        efficiency_values = [row[1] for row in hist['efficiency'] if row[1] is not None]

        # Get last 5 years for log-diff calculation
        recent_years = [y for y in efficiency_years if y >= base_year - 5]
        recent_efficiency = [efficiency_values[efficiency_years.index(y)] for y in recent_years]

        # Get last 3 years to check if increasing or decreasing
        very_recent_years = [y for y in efficiency_years if y >= base_year - 3]
        very_recent_efficiency = [efficiency_values[efficiency_years.index(y)] for y in very_recent_years]

        base_efficiency = efficiency_values[-1] if efficiency_values else 8.0

        # Check if efficiency is increasing (getting worse) in last 3 years
        efficiency_increasing = False
        if len(very_recent_efficiency) >= 2:
            efficiency_increasing = very_recent_efficiency[-1] > very_recent_efficiency[0]

        # Calculate this country's 5-year log-diff rate
        country_log_diff_rate = 0
        if len(recent_efficiency) >= 2 and len(recent_years) >= 2:
            country_log_diff_rate = calculate_log_diff_rate(recent_efficiency, recent_years)
    else:
        base_efficiency = 8.0
        efficiency_increasing = False
        country_log_diff_rate = 0

    # Km per vehicle (assume constant)
    if hist['km'] and hist['vehicles']:
        km_years = [row[0] for row in hist['km']]
        km_values = [row[1] * 1e6 for row in hist['km']]  # Convert millions to actual km

        km_per_veh_values = []
        for year in km_years:
            veh_idx = vehicle_years.index(year) if year in vehicle_years else None
            if veh_idx is not None and vehicle_values[veh_idx] > 0:
                km_per_veh = km_values[km_years.index(year)] / vehicle_values[veh_idx]
                km_per_veh_values.append(km_per_veh)

        base_km_per_veh = km_per_veh_values[-1] if km_per_veh_values else 12000
    else:
        base_km_per_veh = 12000  # Default: 12,000 km per vehicle

    # Get gasoline/diesel split from historical data
    if hist['fuel']:
        last_fuel = hist['fuel'][-1]
        total_fuel = last_fuel[1] + last_fuel[2]
        gasoline_share = last_fuel[1] / total_fuel if total_fuel > 0 else 0.7
    else:
        gasoline_share = 0.7  # Default 70% gasoline, 30% diesel

    # EV adoption parameters (sigmoid curve)
    ev_saturation = 0.80  # 80% maximum
    ev_midpoint_year = base_year + 15  # Half adoption in 15 years
    ev_steepness = 0.3  # Steepness of curve

    print(f"  {country_code}:")
    print(f"    Base year: {base_year}")
    print(f"    Population growth: {pop_growth_rate*100:.2f}% per year")
    print(f"    Cars per capita: {base_cars_per_capita:.3f} -> converging to 0.5")
    print(f"    Base efficiency: {base_efficiency:.2f} L/100km")
    print(f"    Efficiency increasing in past 3 years: {efficiency_increasing}")
    if efficiency_increasing:
        print(f"    Will converge to USA ({usa_current_efficiency:.2f} L/100km) at rate {country_log_diff_rate:.4f}")
    else:
        print(f"    Will follow USA log-diff rate: {usa_log_diff_rate:.4f}")
    print(f"    Base EV share: {base_ev_share*100:.1f}%")

    # Generate forecasts for both scenarios
    forecasts = []

    for scenario in ['age_out', 'improvement']:
        for year in forecast_years:
            years_ahead = year - base_year

            # Population forecast
            pop = base_population * (1 + pop_growth_rate) ** years_ahead

            # Cars per capita - converge to 0.5
            cars_per_capita = converge_to_target(base_cars_per_capita, target_cars_per_capita, years_ahead)
            total_vehicles = pop * cars_per_capita

            # EV adoption (sigmoid)
            ev_share = sigmoid(year, ev_saturation, ev_steepness, ev_midpoint_year)
            ev_vehicles = total_vehicles * ev_share
            ice_vehicles = total_vehicles * (1 - ev_share)

            # Fuel efficiency forecast (L/100km)
            if scenario == 'age_out':
                # Fleet ages out to current benchmark (constant)
                fuel_efficiency = base_efficiency
            else:
                # Improvement scenario
                if efficiency_increasing:
                    # Converge to USA at country's own rate
                    fuel_efficiency = converge_to_target(base_efficiency, usa_current_efficiency, years_ahead)
                else:
                    # Follow USA's log-diff rate (compound annual % change)
                    fuel_efficiency = base_efficiency * np.exp(usa_log_diff_rate * years_ahead)
                    # Cap at USA's efficiency (don't get better than USA)
                    fuel_efficiency = max(fuel_efficiency, usa_current_efficiency)

            # Fuel demand calculation
            # Only ICE vehicles consume fuel
            # Fuel consumption = vehicles * km_per_vehicle * L_per_100km / 100
            fuel_L = ice_vehicles * base_km_per_veh * fuel_efficiency / 100

            # Convert liters to TJ
            # 1 liter gasoline ≈ 0.0000347 TJ
            # 1 liter diesel ≈ 0.0000380 TJ
            fuel_tj = fuel_L * 0.0000347 / 0.7  # Average between gas and diesel

            gasoline_tj = fuel_tj * gasoline_share
            diesel_tj = fuel_tj * (1 - gasoline_share)

            forecasts.append({
                'country_code': country_code,
                'country_name': country_name,
                'year': year,
                'efficiency_scenario': scenario,
                'population': pop,
                'total_vehicles': total_vehicles,
                'ev_vehicles': ev_vehicles,
                'ice_vehicles': ice_vehicles,
                'ev_share': ev_share,
                'cars_per_capita': cars_per_capita,
                'km_per_vehicle': base_km_per_veh,
                'fuel_efficiency_L100km': fuel_efficiency,
                'gasoline_demand_tj': gasoline_tj,
                'diesel_demand_tj': diesel_tj,
                'total_fuel_demand_tj': fuel_tj
            })

    return forecasts


def insert_forecasts(conn, forecasts):
    """Insert forecast data into database."""
    cursor = conn.cursor()

    for f in forecasts:
        cursor.execute("""
            INSERT OR REPLACE INTO forecast_data
            (country_code, country_name, year, efficiency_scenario, population, total_vehicles, ev_vehicles,
             ice_vehicles, ev_share, cars_per_capita, km_per_vehicle, fuel_efficiency_L100km,
             gasoline_demand_tj, diesel_demand_tj, total_fuel_demand_tj)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            f['country_code'], f['country_name'], f['year'], f['efficiency_scenario'], f['population'],
            f['total_vehicles'], f['ev_vehicles'], f['ice_vehicles'], f['ev_share'],
            f['cars_per_capita'], f['km_per_vehicle'], f['fuel_efficiency_L100km'],
            f['gasoline_demand_tj'], f['diesel_demand_tj'], f['total_fuel_demand_tj']
        ))

    conn.commit()


def get_usa_efficiency_trend(cursor):
    """Get USA's efficiency log-diff rate from past 5 years."""
    cursor.execute("""
        SELECT year, fleet_avg_L100
        FROM fuel_consumption_benchmarks_historical
        WHERE country_code = 'USA'
        AND fleet_avg_L100 IS NOT NULL
        ORDER BY year DESC
        LIMIT 6
    """)

    data = cursor.fetchall()
    if len(data) < 2:
        print("Warning: Insufficient USA efficiency data, using default rate")
        return -0.015, 10.0  # Default: -1.5% per year, 10 L/100km

    years = [row[0] for row in reversed(data)]
    efficiency = [row[1] for row in reversed(data)]

    # Get last 5 years
    if len(years) > 5:
        years = years[-5:]
        efficiency = efficiency[-5:]

    log_diff_rate = calculate_log_diff_rate(efficiency, years)
    current_efficiency = efficiency[-1]

    print(f"\nUSA Efficiency Trend:")
    print(f"  Years: {years[0]}-{years[-1]}")
    print(f"  Current: {current_efficiency:.2f} L/100km")
    print(f"  Log-diff rate: {log_diff_rate:.4f} ({log_diff_rate*100:.2f}% per year)")

    return log_diff_rate, current_efficiency


def main():
    """Main function."""
    db_path = Path('iea_oil.db')

    print(f"Opening database: {db_path}")
    conn = sqlite3.connect(db_path)

    try:
        # Build forecast tables
        build_forecast_tables(conn)

        # Get USA's efficiency trend first
        cursor = conn.cursor()
        usa_log_diff_rate, usa_current_efficiency = get_usa_efficiency_trend(cursor)

        # Countries to exclude (small countries with patchy data)
        excluded_countries = {'austria', 'belgium', 'greece', 'latvia', 'luxembourg', 'portugal'}

        # Get list of countries
        cursor.execute("""
            SELECT DISTINCT iea_code, oecd_code, wb_code, country_name
            FROM country_code_mapping
            WHERE oecd_code IS NOT NULL
            ORDER BY country_name
        """)
        all_countries = cursor.fetchall()

        # Filter out excluded countries
        countries = [c for c in all_countries if c[0] not in excluded_countries]

        print(f"\nGenerating forecasts for {len(countries)} countries...")
        print(f"Excluded {len(all_countries) - len(countries)} countries with patchy data")
        print("Forecast period: 2024-2040")
        print("Efficiency scenarios: age_out, improvement\n")

        forecast_years = list(range(2024, 2041))  # 2024-2040

        all_forecasts = []
        for iea_code, oecd_code, wb_code, country_name in countries:
            try:
                forecasts = forecast_country(cursor, iea_code, oecd_code, wb_code, country_name,
                                            forecast_years, usa_log_diff_rate, usa_current_efficiency)
                all_forecasts.extend(forecasts)
            except Exception as e:
                print(f"  {iea_code}: Error - {e}")

        # Insert all forecasts
        print(f"\nInserting {len(all_forecasts)} forecast records...")
        insert_forecasts(conn, all_forecasts)

        # Summary
        cursor.execute("SELECT COUNT(DISTINCT country_code) FROM forecast_data")
        country_count = cursor.fetchone()[0]

        cursor.execute("SELECT MIN(year), MAX(year) FROM forecast_data")
        year_range = cursor.fetchone()

        cursor.execute("SELECT COUNT(*) FROM forecast_data")
        record_count = cursor.fetchone()[0]

        cursor.execute("SELECT efficiency_scenario, COUNT(*) FROM forecast_data GROUP BY efficiency_scenario")
        scenario_counts = cursor.fetchall()

        print("\n" + "="*70)
        print("Forecast models completed!")
        print("="*70)
        print(f"Countries: {country_count}")
        print(f"Years: {year_range[0]}-{year_range[1]}")
        print(f"Scenarios: {', '.join([f'{s[0]} ({s[1]} records)' for s in scenario_counts])}")
        print(f"Total records: {record_count}")

    finally:
        conn.close()


if __name__ == '__main__':
    main()
