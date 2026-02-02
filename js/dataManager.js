// Data Manager - handles loading and querying oil data
export class DataManager {
    constructor() {
        this.countries = {};
        this.oilConsumption = {};
        this.summary = {};
        this.kayaData = {};
        this.evStock = {};
        this.vehicleCategories = {};
        this.fuelBenchmarks = {};
        this.fuelBenchmarksHistorical = {};
    }

    async loadAll() {
        const [countries, oilConsumption, summary, kayaData, evStock, vehicleCategories, fuelBenchmarks, fuelBenchmarksHistorical] = await Promise.all([
            fetch('data/countries.json').then(r => r.json()),
            fetch('data/oil_consumption.json').then(r => r.json()),
            fetch('data/summary.json').then(r => r.json()),
            fetch('data/kaya_data.json').then(r => r.json()),
            fetch('data/ev_stock.json').then(r => r.json()),
            fetch('data/vehicle_categories.json').then(r => r.json()),
            fetch('data/fuel_benchmarks.json').then(r => r.json()),
            fetch('data/fuel_benchmarks_historical.json').then(r => r.json())
        ]);

        this.countries = countries;
        this.oilConsumption = oilConsumption;
        this.summary = summary;
        this.kayaData = kayaData;
        this.evStock = evStock;
        this.vehicleCategories = vehicleCategories;
        this.fuelBenchmarks = fuelBenchmarks;
        this.fuelBenchmarksHistorical = fuelBenchmarksHistorical;
    }

    getYears() {
        return this.summary.years || [];
    }

    getCountryName(countryCode) {
        return this.countries[countryCode] || countryCode.replace(/-/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
    }

    getHeatmapData(indicator, year, source = 'total', valueType = 'absolute', baseYear = null) {
        const data = [];
        const kayaVariables = ['population', 'cars_per_pop', 'km_per_veh', 'gasoline_per_km', 'gasoline_total'];

        for (const countryCode in this.countries) {
            let value = null;
            let baseValue = null;

            // Check if this is a Kaya variable
            if (kayaVariables.includes(indicator)) {
                const countryKayaData = this.kayaData[countryCode];
                if (countryKayaData && countryKayaData[year]) {
                    // Map indicator name to data field
                    const fieldMap = {
                        'population': 'pop',
                        'cars_per_pop': 'cars_per_pop',
                        'km_per_veh': 'km_per_veh',
                        'gasoline_per_km': 'gasoline_per_km',
                        'gasoline_total': 'gasoline_total'
                    };

                    const field = fieldMap[indicator];
                    value = countryKayaData[year][field] || null;

                    if (valueType === 'indexed' && baseYear && countryKayaData[baseYear]) {
                        baseValue = countryKayaData[baseYear][field] || null;
                    }
                }
            } else {
                // Oil consumption data
                const countryData = this.oilConsumption[countryCode];
                if (countryData && countryData[year]) {
                    if (indicator === 'total') {
                        // Sum all products
                        value = Object.values(countryData[year]).reduce((sum, val) => sum + (val || 0), 0);
                        if (valueType === 'indexed' && baseYear && countryData[baseYear]) {
                            baseValue = Object.values(countryData[baseYear]).reduce((sum, val) => sum + (val || 0), 0);
                        }
                    } else {
                        // Specific product
                        value = countryData[year][indicator] || null;
                        if (valueType === 'indexed' && baseYear && countryData[baseYear]) {
                            baseValue = countryData[baseYear][indicator] || null;
                        }
                    }
                }
            }

            // Calculate indexed value if requested
            if (valueType === 'indexed' && baseValue !== null && baseValue !== 0) {
                value = (value / baseValue) * 100;
            }

            if (value !== null && value !== 0) {
                data.push({ country: countryCode, value });
            }
        }

        return data;
    }

    getOilConsumptionTimeSeries(countryCode, indexed = false, baseYear = null) {
        const countryData = this.oilConsumption[countryCode];
        if (!countryData) return null;

        // Get all years and products
        const years = Object.keys(countryData).map(Number).sort((a, b) => a - b);
        const products = new Set();

        years.forEach(year => {
            Object.keys(countryData[year]).forEach(product => products.add(product));
        });

        // Determine base year
        if (indexed && (!baseYear || !countryData[baseYear])) {
            baseYear = years[0]; // Use first available year as base
        }

        const datasets = [];
        const productColors = {
            'Motor gasoline': '#FF6B6B',
            'Gas/Diesel': '#4ECDC4',
            'Jet kerosene': '#45B7D1',
            'LPG/Ethane': '#FFA07A',
            'Fuel oil': '#98D8C8',
            'Naphtha': '#F7B731',
            'Other kerosene': '#5F27CD',
            'Other oil products': '#BDBDBD',
            'Crude oil/NGL': '#2C3E50'
        };

        Array.from(products).forEach(product => {
            let data;
            if (indexed) {
                const baseValue = countryData[baseYear][product] || 0;
                data = years.map(year => {
                    const value = countryData[year][product] || 0;
                    return baseValue > 0 ? (value / baseValue) * 100 : 0;
                });
            } else {
                data = years.map(year => countryData[year][product] || 0);
            }

            datasets.push({
                label: product,
                data: data,
                backgroundColor: productColors[product] || '#888',
                borderWidth: 0
            });
        });

        return { labels: years, datasets, indexed, baseYear };
    }

    getKayaData(countryCode, indexed = false, baseYear = null) {
        // Get Kaya identity decomposition
        // gasoline = pop × cars/pop × km/veh × gasoline/km
        const countryData = this.kayaData[countryCode];
        if (!countryData) return null;

        const years = Object.keys(countryData).map(Number).sort((a, b) => a - b);
        if (years.length === 0) return null;

        // Determine base year
        if (!baseYear || !countryData[baseYear]) {
            baseYear = years[0]; // Use first available year as base
        }

        const baseData = countryData[baseYear];

        // Prepare datasets for each component
        const datasets = [];

        if (indexed) {
            // Indexed values (base year = 100)
            datasets.push(
                {
                    label: 'Population',
                    data: years.map(year => (countryData[year].pop / baseData.pop) * 100),
                    borderColor: '#4FC3F7',
                    yAxisID: 'y',
                    fill: false
                },
                {
                    label: 'Cars/Population',
                    data: years.map(year => (countryData[year].cars_per_pop / baseData.cars_per_pop) * 100),
                    borderColor: '#81C784',
                    yAxisID: 'y',
                    fill: false
                },
                {
                    label: 'Km/Vehicle',
                    data: years.map(year => (countryData[year].km_per_veh / baseData.km_per_veh) * 100),
                    borderColor: '#FFD54F',
                    yAxisID: 'y',
                    fill: false
                },
                {
                    label: 'Gasoline/Km',
                    data: years.map(year => (countryData[year].gasoline_per_km / baseData.gasoline_per_km) * 100),
                    borderColor: '#FF6B6B',
                    yAxisID: 'y',
                    fill: false
                },
                {
                    label: 'Total Gasoline',
                    data: years.map(year => (countryData[year].gasoline_total / baseData.gasoline_total) * 100),
                    borderColor: '#AB47BC',
                    yAxisID: 'y',
                    borderWidth: 3,
                    fill: false
                }
            );
        } else {
            // Absolute values
            datasets.push(
                {
                    label: 'Population (millions)',
                    data: years.map(year => countryData[year].pop / 1_000_000),
                    borderColor: '#4FC3F7',
                    yAxisID: 'y',
                    fill: false
                },
                {
                    label: 'Cars/Population (cars per person)',
                    data: years.map(year => countryData[year].cars_per_pop),
                    borderColor: '#81C784',
                    yAxisID: 'y1',
                    fill: false
                },
                {
                    label: 'Km/Vehicle (thousand km/year)',
                    data: years.map(year => countryData[year].km_per_veh / 1000),
                    borderColor: '#FFD54F',
                    yAxisID: 'y2',
                    fill: false
                },
                {
                    label: 'Gasoline/Km (TJ per million km)',
                    data: years.map(year => countryData[year].gasoline_per_km * 1_000_000),
                    borderColor: '#FF6B6B',
                    yAxisID: 'y3',
                    fill: false
                },
                {
                    label: 'Total Gasoline (thousand TJ)',
                    data: years.map(year => countryData[year].gasoline_total / 1000),
                    borderColor: '#AB47BC',
                    yAxisID: 'y4',
                    borderWidth: 3,
                    fill: false
                }
            );
        }

        return { labels: years, datasets, indexed, baseYear };
    }

    getVehicleCategoryData(countryCode) {
        // Get vehicle category mix (passenger vs freight)
        const countryData = this.vehicleCategories[countryCode];
        if (!countryData) return null;

        const years = Object.keys(countryData).map(Number).sort((a, b) => a - b);
        if (years.length === 0) return null;

        const passengerKm = [];
        const freightKm = [];

        years.forEach(year => {
            const passenger = countryData[year].passenger?.km_millions || 0;
            const freight = countryData[year].freight?.km_millions || 0;
            passengerKm.push(passenger);
            freightKm.push(freight);
        });

        return {
            labels: years,
            datasets: [
                {
                    label: 'Passenger (million km)',
                    data: passengerKm,
                    backgroundColor: '#4FC3F7',
                    borderWidth: 0
                },
                {
                    label: 'Freight (million tonne-km)',
                    data: freightKm,
                    backgroundColor: '#FFD54F',
                    borderWidth: 0
                }
            ]
        };
    }

    getRawDataMetrics(countryCode) {
        // Get raw data metrics: cars, pop, fuel totals, km
        const countryData = this.kayaData[countryCode];
        if (!countryData) return null;

        const years = Object.keys(countryData).map(Number).sort((a, b) => a - b);
        if (years.length === 0) return null;

        return {
            labels: years,
            datasets: [
                {
                    label: 'Population (millions)',
                    data: years.map(year => {
                        const val = countryData[year].population;
                        return val != null ? val / 1_000_000 : null;
                    }),
                    borderColor: '#4FC3F7',
                    yAxisID: 'y',
                    fill: false,
                    spanGaps: false
                },
                {
                    label: 'Total Vehicles (millions)',
                    data: years.map(year => {
                        const val = countryData[year].vehicles;
                        return val != null ? val / 1_000_000 : null;
                    }),
                    borderColor: '#81C784',
                    yAxisID: 'y1',
                    fill: false,
                    spanGaps: false
                },
                {
                    label: 'Total Fuel (thousand TJ)',
                    data: years.map(year => {
                        const val = countryData[year].fuel_total_tj;
                        return val != null ? val / 1000 : null;
                    }),
                    borderColor: '#AB47BC',
                    yAxisID: 'y2',
                    borderWidth: 3,
                    fill: false,
                    spanGaps: false
                },
                {
                    label: 'Gasoline (thousand TJ)',
                    data: years.map(year => {
                        const val = countryData[year].gasoline_tj;
                        return val != null ? val / 1000 : null;
                    }),
                    borderColor: '#FF6B6B',
                    yAxisID: 'y2',
                    fill: false,
                    spanGaps: false
                },
                {
                    label: 'Diesel (thousand TJ)',
                    data: years.map(year => {
                        const val = countryData[year].diesel_tj;
                        return val != null ? val / 1000 : null;
                    }),
                    borderColor: '#FFA07A',
                    yAxisID: 'y2',
                    fill: false,
                    spanGaps: false
                },
                {
                    label: 'Passenger Km (billion km)',
                    data: years.map(year => {
                        const val = countryData[year].passenger_km;
                        return val != null ? val / 1_000_000_000 : null;
                    }),
                    borderColor: '#FFD54F',
                    yAxisID: 'y3',
                    fill: false,
                    spanGaps: false
                }
            ]
        };
    }

    getDerivedFeatures(countryCode) {
        // Get derived features: fuel efficiency, km/car, cars/capita
        const countryData = this.kayaData[countryCode];
        if (!countryData) return null;

        const years = Object.keys(countryData).map(Number).sort((a, b) => a - b);
        if (years.length === 0) return null;

        return {
            labels: years,
            datasets: [
                {
                    label: 'Cars per Capita',
                    data: years.map(year => countryData[year].cars_per_capita != null ? countryData[year].cars_per_capita : null),
                    borderColor: '#81C784',
                    yAxisID: 'y',
                    fill: false,
                    spanGaps: false
                },
                {
                    label: 'Km per Vehicle (thousands)',
                    data: years.map(year => {
                        const val = countryData[year].km_per_vehicle;
                        return val != null ? val / 1000 : null;
                    }),
                    borderColor: '#FFD54F',
                    yAxisID: 'y1',
                    fill: false,
                    spanGaps: false
                },
                {
                    label: 'Fuel Efficiency (L/100km)',
                    data: years.map(year => countryData[year].fuel_efficiency_L_per_100km != null ? countryData[year].fuel_efficiency_L_per_100km : null),
                    borderColor: '#FF6B6B',
                    yAxisID: 'y2',
                    fill: false,
                    spanGaps: false
                }
            ]
        };
    }

    getFuelSavedData(countryCode, baseYear = null) {
        // Calculate "fuel not used" due to efficiency gains
        // Compares actual fuel consumption to counterfactual scenarios
        const countryData = this.kayaData[countryCode];
        if (!countryData) return null;

        const years = Object.keys(countryData).map(Number).sort((a, b) => a - b);
        if (years.length === 0) return null;

        // Use 2010 as base year, or first year if not specified
        if (!baseYear || !countryData[baseYear]) {
            baseYear = countryData[2010] ? 2010 : years[0];
        }

        // Filter years to start from 2010
        const filteredYears = years.filter(year => year >= 2010);

        const baseData = countryData[baseYear];
        if (!baseData.fuel_total_tj || !baseData.population || !baseData.vehicles || !baseData.passenger_km) {
            return null;
        }

        // Calculate baseline ratios
        const baseFuelPerKm = baseData.fuel_total_tj / baseData.passenger_km;
        const baseCarsPerCapita = baseData.vehicles / baseData.population;
        const baseKmPerVeh = baseData.passenger_km / baseData.vehicles;

        const actualFuel = [];
        const fuelSavedEfficiency = [];
        const fuelSavedElectrification = [];
        const fuelSavedOwnership = [];

        filteredYears.forEach(year => {
            const data = countryData[year];
            if (!data.fuel_total_tj || !data.population || !data.vehicles || !data.passenger_km ||
                data.fuel_total_tj === 0 || data.population === 0 || data.vehicles === 0 || data.passenger_km === 0) {
                actualFuel.push(null);
                fuelSavedEfficiency.push(null);
                fuelSavedElectrification.push(null);
                fuelSavedOwnership.push(null);
                return;
            }

            const actual = data.fuel_total_tj;
            actualFuel.push(actual);

            // Counterfactual 1: What if efficiency stayed at base year level?
            const counterfactualFuel_noEfficiency = data.passenger_km * baseFuelPerKm;
            const savedFromEfficiency = Math.max(0, counterfactualFuel_noEfficiency - actual);
            fuelSavedEfficiency.push(savedFromEfficiency);

            // Counterfactual 2: Electrification effect (simplified)
            // Assume EVs would have consumed fuel at the base efficiency rate
            const evStock = this.evStock[countryCode];
            let evShare = 0;
            if (evStock && evStock[year]) {
                const total = evStock[year].total || 0;
                const electric = evStock[year].electric || 0;
                evShare = total > 0 ? electric / total : 0;
            }
            const savedFromEV = evShare * data.passenger_km * baseFuelPerKm;
            fuelSavedElectrification.push(savedFromEV);

            // Counterfactual 3: Car ownership changes
            const actualCarsPerCapita = data.vehicles / data.population;
            const ownershipChange = baseCarsPerCapita - actualCarsPerCapita;
            if (ownershipChange > 0) {
                // Fewer cars per capita = fuel saved
                const savedFromOwnership = ownershipChange * data.population * baseKmPerVeh * baseFuelPerKm;
                fuelSavedOwnership.push(Math.max(0, savedFromOwnership));
            } else {
                fuelSavedOwnership.push(0);
            }
        });

        return {
            labels: filteredYears,
            datasets: [
                {
                    label: 'Fuel Saved: Efficiency Improvements',
                    data: fuelSavedEfficiency,
                    backgroundColor: '#81C784',
                    borderWidth: 0
                },
                {
                    label: 'Fuel Saved: Electrification',
                    data: fuelSavedElectrification,
                    backgroundColor: '#4FC3F7',
                    borderWidth: 0
                },
                {
                    label: 'Fuel Saved: Lower Car Ownership',
                    data: fuelSavedOwnership,
                    backgroundColor: '#FFD54F',
                    borderWidth: 0
                }
            ],
            baseYear: baseYear
        };
    }

    getEfficiencyTrendsData(countryCode) {
        // Get efficiency trends with regional benchmarks
        const countryData = this.kayaData[countryCode];
        if (!countryData) return null;

        const allYears = Object.keys(countryData).map(Number).sort((a, b) => a - b);
        if (allYears.length === 0) return null;

        // Filter years to start from 2010
        const years = allYears.filter(year => year >= 2010);
        if (years.length === 0) return null;

        // Get the country's historical benchmark data
        const historicalBenchmarks = this.fuelBenchmarksHistorical[countryCode];
        const region = historicalBenchmarks?.[years[0]]?.region || this.fuelBenchmarks[countryCode]?.region || 'Unknown';

        // Calculate observed fleet efficiency
        const observedEfficiency = years.map(year => {
            const data = countryData[year];
            return data.fuel_efficiency_L_per_100km || null;
        });

        // Get time series benchmark values from historical data
        const suvBenchmarkTimeSeries = years.map(year => {
            return historicalBenchmarks?.[year]?.suv_L100 || null;
        });

        const carBenchmarkTimeSeries = years.map(year => {
            return historicalBenchmarks?.[year]?.car_L100 || null;
        });

        const fleetAvgBenchmark = years.map(year => {
            return historicalBenchmarks?.[year]?.fleet_avg_L100 || null;
        });

        // Calculate EV penetration (assume 80% passenger, 20% freight as per requirements)
        const evPenetration = years.map(year => {
            const evStock = this.evStock[countryCode];
            if (!evStock || !evStock[year]) return 0;

            const total = evStock[year].total || 0;
            const electric = evStock[year].electric || 0;
            return total > 0 ? (electric / total) * 100 : 0;
        });

        return {
            labels: years,
            datasets: [
                {
                    label: 'Observed Fleet Efficiency (L/100km)',
                    data: observedEfficiency,
                    borderColor: '#AB47BC',
                    backgroundColor: 'transparent',
                    borderWidth: 3,
                    yAxisID: 'y',
                    fill: false,
                    spanGaps: false
                },
                {
                    label: `New SUV Benchmark (${region})`,
                    data: suvBenchmarkTimeSeries,
                    borderColor: '#FF6B6B',
                    backgroundColor: 'transparent',
                    borderWidth: 2,
                    borderDash: [5, 5],
                    yAxisID: 'y',
                    fill: false,
                    spanGaps: false
                },
                {
                    label: `New Sedan Benchmark (${region})`,
                    data: carBenchmarkTimeSeries,
                    borderColor: '#4FC3F7',
                    backgroundColor: 'transparent',
                    borderWidth: 2,
                    borderDash: [5, 5],
                    yAxisID: 'y',
                    fill: false,
                    spanGaps: false
                },
                {
                    label: `Fleet Average Benchmark (${region})`,
                    data: fleetAvgBenchmark,
                    borderColor: '#FFD54F',
                    backgroundColor: 'transparent',
                    borderWidth: 2,
                    borderDash: [3, 3],
                    yAxisID: 'y',
                    fill: false,
                    spanGaps: false
                },
                {
                    label: 'EV Penetration (%)',
                    data: evPenetration,
                    borderColor: '#81C784',
                    backgroundColor: 'transparent',
                    borderWidth: 2,
                    yAxisID: 'y1',
                    fill: false,
                    spanGaps: false
                }
            ],
            region: region
        };
    }

    getEVData(countryCode, mode = 'absolute') {
        // Get EV stock data
        const countryData = this.evStock[countryCode];
        if (!countryData) return null;

        const years = Object.keys(countryData).map(Number).sort((a, b) => a - b);
        if (years.length === 0) return null;

        if (mode === 'share') {
            // Calculate share for each year - bar chart
            const electricShare = [];
            const hybridShare = [];
            const conventionalShare = [];

            years.forEach(year => {
                const total = countryData[year].total || 0;
                const electric = countryData[year].electric || 0;
                const hybrid = countryData[year].hybrid || 0;
                const conventional = total - electric - hybrid;

                if (total > 0) {
                    electricShare.push((electric / total) * 100);
                    hybridShare.push((hybrid / total) * 100);
                    conventionalShare.push((conventional / total) * 100);
                } else {
                    electricShare.push(0);
                    hybridShare.push(0);
                    conventionalShare.push(0);
                }
            });

            return {
                labels: years,
                datasets: [
                    {
                        label: 'Electric',
                        data: electricShare,
                        backgroundColor: '#4FC3F7',
                        borderWidth: 0
                    },
                    {
                        label: 'Hybrid',
                        data: hybridShare,
                        backgroundColor: '#81C784',
                        borderWidth: 0
                    },
                    {
                        label: 'Conventional',
                        data: conventionalShare,
                        backgroundColor: '#BDBDBD',
                        borderWidth: 0
                    }
                ],
                mode: 'share'
            };
        } else {
            // Absolute values - line chart
            return {
                labels: years,
                datasets: [
                    {
                        label: 'Total Fleet',
                        data: years.map(year => countryData[year].total || 0),
                        borderColor: '#AB47BC',
                        backgroundColor: 'transparent',
                        borderWidth: 3,
                        fill: false
                    },
                    {
                        label: 'Electric',
                        data: years.map(year => countryData[year].electric || 0),
                        borderColor: '#4FC3F7',
                        backgroundColor: 'transparent',
                        fill: false
                    },
                    {
                        label: 'Hybrid',
                        data: years.map(year => countryData[year].hybrid || 0),
                        borderColor: '#81C784',
                        backgroundColor: 'transparent',
                        fill: false
                    }
                ],
                mode: 'absolute'
            };
        }
    }
}
