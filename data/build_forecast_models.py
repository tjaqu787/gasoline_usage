#!/usr/bin/env python3
"""
Build forecast models for gasoline demand.

Forecast components:
1. Population growth - extrapolate from past 10 years
2. EV adoption - sigmoid curve reaching 80% saturation for passenger vehicles
3. Fuel efficiency - improve at same rate as past 10 years
4. Car ownership - change at same rate as past 10 years
"""

import sqlite3
import numpy as np
from pathlib import Path
from datetime import datetime


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


def calculate_linear_trend(values):
    """Calculate linear trend (change per year)."""
    if len(values) < 2:
        return 0.0

    # Simple linear regression
    x = np.arange(len(values))
    y = np.array(values)

    # Remove NaNs
    mask = ~np.isnan(y)
    if mask.sum() < 2:
        return 0.0

    x = x[mask]
    y = y[mask]

    # Fit line
    coeffs = np.polyfit(x, y, 1)
    return coeffs[0]  # slope


def build_forecast_tables(conn):
    """Create forecast tables."""
    cursor = conn.cursor()

    # Drop existing tables
    cursor.execute("DROP TABLE IF EXISTS forecast_data")
    cursor.execute("DROP VIEW IF EXISTS forecast_summary")

    # Create forecast table
    cursor.execute("""
        CREATE TABLE forecast_data (
            country_code TEXT NOT NULL,
            country_name TEXT NOT NULL,
            year INTEGER NOT NULL,
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
            UNIQUE(country_code, year)
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

    # Get fuel efficiency benchmarks (last 10 years)
    cursor.execute("""
        SELECT year, fleet_avg_L100
        FROM fuel_consumption_benchmarks_historical
        WHERE country_code = ?
        AND year >= 2013
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


def forecast_country(cursor, country_code, oecd_code, wb_code, country_name, forecast_years):
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

    # Calculate growth rates
    pop_years = [row[0] for row in hist['population']]
    pop_values = [row[1] for row in hist['population']]
    pop_growth_rate = calculate_growth_rate(pop_values, pop_years)

    # Vehicle ownership trend (cars per capita change)
    vehicle_years = [row[0] for row in hist['vehicles']]
    vehicle_values = [row[1] for row in hist['vehicles']]

    # Match vehicles with population
    cars_per_capita_values = []
    for year in vehicle_years:
        pop_idx = pop_years.index(year) if year in pop_years else None
        if pop_idx is not None:
            cars_per_capita = vehicle_values[vehicle_years.index(year)] / pop_values[pop_idx]
            cars_per_capita_values.append(cars_per_capita)

    ownership_trend = calculate_linear_trend(cars_per_capita_values)
    base_cars_per_capita = cars_per_capita_values[-1] if cars_per_capita_values else 0

    # Fuel efficiency trend (L/100km - should be decreasing)
    if hist['efficiency']:
        efficiency_values = [row[1] for row in hist['efficiency'] if row[1] is not None]
        efficiency_trend = calculate_linear_trend(efficiency_values)
        base_efficiency = efficiency_values[-1] if efficiency_values else 8.0
    else:
        efficiency_trend = -0.1  # Default: improve by 0.1 L/100km per year
        base_efficiency = 8.0

    # Km per vehicle (assume constant or slight decline)
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
    print(f"    Ownership trend: {ownership_trend*1000:.2f} cars per 1000 people per year")
    print(f"    Efficiency trend: {efficiency_trend:.3f} L/100km per year")
    print(f"    Base EV share: {base_ev_share*100:.1f}%")

    # Generate forecasts
    forecasts = []

    for year in forecast_years:
        years_ahead = year - base_year

        # Population forecast
        pop = base_population * (1 + pop_growth_rate) ** years_ahead

        # Cars per capita forecast
        cars_per_capita = max(0, base_cars_per_capita + ownership_trend * years_ahead)
        total_vehicles = pop * cars_per_capita

        # EV adoption (sigmoid)
        ev_share = sigmoid(year, ev_saturation, ev_steepness, ev_midpoint_year)
        ev_vehicles = total_vehicles * ev_share
        ice_vehicles = total_vehicles * (1 - ev_share)

        # Fuel efficiency forecast (L/100km)
        fuel_efficiency = max(3.0, base_efficiency + efficiency_trend * years_ahead)

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
            (country_code, country_name, year, population, total_vehicles, ev_vehicles,
             ice_vehicles, ev_share, cars_per_capita, km_per_vehicle, fuel_efficiency_L100km,
             gasoline_demand_tj, diesel_demand_tj, total_fuel_demand_tj)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """, (
            f['country_code'], f['country_name'], f['year'], f['population'],
            f['total_vehicles'], f['ev_vehicles'], f['ice_vehicles'], f['ev_share'],
            f['cars_per_capita'], f['km_per_vehicle'], f['fuel_efficiency_L100km'],
            f['gasoline_demand_tj'], f['diesel_demand_tj'], f['total_fuel_demand_tj']
        ))

    conn.commit()


def create_forecast_views(conn):
    """Create database views for forecast data."""
    cursor = conn.cursor()

    # View: Aggregate forecast summary
    cursor.execute("""
        CREATE VIEW IF NOT EXISTS forecast_summary AS
        SELECT
            year,
            SUM(population) as total_population,
            SUM(total_vehicles) as total_vehicles,
            SUM(ev_vehicles) as total_ev_vehicles,
            AVG(ev_share) as avg_ev_share,
            AVG(fuel_efficiency_L100km) as avg_fuel_efficiency,
            SUM(gasoline_demand_tj) as total_gasoline_demand_tj,
            SUM(diesel_demand_tj) as total_diesel_demand_tj,
            SUM(total_fuel_demand_tj) as total_fuel_demand_tj
        FROM forecast_data
        GROUP BY year
        ORDER BY year
    """)

    conn.commit()
    print("Forecast views created")


def main():
    """Main function."""
    db_path = Path('iea_oil.db')

    print(f"Opening database: {db_path}")
    conn = sqlite3.connect(db_path)

    try:
        # Build forecast tables
        build_forecast_tables(conn)

        # Get list of countries
        cursor = conn.cursor()
        cursor.execute("""
            SELECT DISTINCT iea_code, oecd_code, wb_code, country_name
            FROM country_code_mapping
            WHERE oecd_code IS NOT NULL
            ORDER BY country_name
        """)
        countries = cursor.fetchall()

        print(f"\nGenerating forecasts for {len(countries)} countries...")
        print("Forecast period: 2024-2040")

        forecast_years = list(range(2024, 2041))  # 2024-2040

        all_forecasts = []
        for iea_code, oecd_code, wb_code, country_name in countries:
            try:
                forecasts = forecast_country(cursor, iea_code, oecd_code, wb_code, country_name, forecast_years)
                all_forecasts.extend(forecasts)
            except Exception as e:
                print(f"  {iea_code}: Error - {e}")

        # Insert all forecasts
        print(f"\nInserting {len(all_forecasts)} forecast records...")
        insert_forecasts(conn, all_forecasts)

        # Create views
        create_forecast_views(conn)

        # Summary
        cursor.execute("SELECT COUNT(DISTINCT country_code) FROM forecast_data")
        country_count = cursor.fetchone()[0]

        cursor.execute("SELECT MIN(year), MAX(year) FROM forecast_data")
        year_range = cursor.fetchone()

        cursor.execute("SELECT COUNT(*) FROM forecast_data")
        record_count = cursor.fetchone()[0]

        print("\n" + "="*70)
        print("Forecast models completed!")
        print("="*70)
        print(f"Countries: {country_count}")
        print(f"Years: {year_range[0]}-{year_range[1]}")
        print(f"Total records: {record_count}")

    finally:
        conn.close()


if __name__ == '__main__':
    main()
