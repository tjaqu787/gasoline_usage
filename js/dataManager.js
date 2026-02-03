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
        this.forecastData = {};
    }

    async loadAll() {
        const [countries, oilConsumption, summary, kayaData, evStock, vehicleCategories, fuelBenchmarks, fuelBenchmarksHistorical, forecastData] = await Promise.all([
            fetch('data/countries.json').then(r => r.json()),
            fetch('data/oil_consumption.json').then(r => r.json()),
            fetch('data/summary.json').then(r => r.json()),
            fetch('data/kaya_data.json').then(r => r.json()),
            fetch('data/ev_stock.json').then(r => r.json()),
            fetch('data/vehicle_categories.json').then(r => r.json()),
            fetch('data/fuel_benchmarks.json').then(r => r.json()),
            fetch('data/fuel_benchmarks_historical.json').then(r => r.json()),
            fetch('data/forecast_data.json').then(r => r.json())
        ]);

        this.countries = countries;
        this.oilConsumption = oilConsumption;
        this.summary = summary;
        this.kayaData = kayaData;
        this.evStock = evStock;
        this.vehicleCategories = vehicleCategories;
        this.fuelBenchmarks = fuelBenchmarks;
        this.fuelBenchmarksHistorical = fuelBenchmarksHistorical;
        this.forecastData = forecastData;
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

    getFuelSavedData(countryCode, baseYear = null, ownershipMetric = 'per_capita') {
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
        const baseTotalVehicles = baseData.vehicles;

        const actualFuel = [];
        const fuelSavedEfficiency = [];
        const fuelSavedElectrification = [];
        const fuelSavedOwnership = [];
        const fuelSavedVMT = [];

        filteredYears.forEach(year => {
            const data = countryData[year];
            if (!data.fuel_total_tj || !data.population || !data.vehicles || !data.passenger_km ||
                data.fuel_total_tj === 0 || data.population === 0 || data.vehicles === 0 || data.passenger_km === 0) {
                actualFuel.push(null);
                fuelSavedEfficiency.push(null);
                fuelSavedElectrification.push(null);
                fuelSavedOwnership.push(null);
                fuelSavedVMT.push(null);
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

            // Counterfactual 3: Car ownership changes (per capita or total)
            let savedFromOwnership;
            if (ownershipMetric === 'per_capita') {
                // Per capita: (base cars/capita - actual cars/capita) * population * km/veh * fuel/km
                const actualCarsPerCapita = data.vehicles / data.population;
                const ownershipChange = baseCarsPerCapita - actualCarsPerCapita;
                savedFromOwnership = ownershipChange * data.population * baseKmPerVeh * baseFuelPerKm;
            } else {
                // Total vehicles: (base total vehicles - actual total vehicles) * km/veh * fuel/km
                const vehicleChange = baseTotalVehicles - data.vehicles;
                savedFromOwnership = vehicleChange * baseKmPerVeh * baseFuelPerKm;
            }
            fuelSavedOwnership.push(savedFromOwnership);

            // Counterfactual 4: VMT (km per vehicle) changes
            const actualKmPerVeh = data.passenger_km / data.vehicles;
            const vmtChange = baseKmPerVeh - actualKmPerVeh;
            // Positive = lower VMT = fuel saved, Negative = higher VMT = fuel added
            const savedFromVMT = vmtChange * data.vehicles * baseFuelPerKm;
            fuelSavedVMT.push(savedFromVMT);
        });

        const ownershipLabel = ownershipMetric === 'per_capita' ? 'Car Ownership (Per Capita)' : 'Car Ownership (Total Vehicles)';

        return {
            labels: filteredYears,
            datasets: [
                {
                    label: 'Efficiency Improvements',
                    data: fuelSavedEfficiency,
                    backgroundColor: '#81C784',
                    borderWidth: 0
                },
                {
                    label: 'Electrification',
                    data: fuelSavedElectrification,
                    backgroundColor: '#4FC3F7',
                    borderWidth: 0
                },
                {
                    label: 'VMT per Vehicle',
                    data: fuelSavedVMT,
                    backgroundColor: '#AB47BC',
                    borderWidth: 0
                },
                {
                    label: ownershipLabel,
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

    getForecastDemandData(countryCode, scenario = 'improvement') {
        /**
         * Get forecast demand decomposition data (similar to fuel saved chart)
         * Shows how different factors contribute to changes in fuel demand
         */
        const forecastCountry = this.forecastData[countryCode];
        if (!forecastCountry || !forecastCountry.scenarios || !forecastCountry.scenarios[scenario]) {
            return null;
        }

        const scenarioData = forecastCountry.scenarios[scenario];
        const years = scenarioData.map(d => d.year);
        const baseYear = years[0];
        const baseData = scenarioData[0];

        // Calculate baseline (if nothing changed from base year)
        const basePopulation = baseData.population;
        const baseCarsPerCapita = baseData.cars_per_capita;
        const baseKmPerVeh = baseData.km_per_vehicle;
        const baseFuelEfficiency = baseData.fuel_efficiency_L100km;

        // Fuel saved/added from each factor
        const fuelFromPopulation = [];
        const fuelFromOwnership = [];
        const fuelFromEfficiency = [];
        const fuelFromEV = [];
        const actualFuel = [];

        scenarioData.forEach(data => {
            // Baseline fuel if nothing changed
            const baselineFuel = (basePopulation * baseCarsPerCapita * baseKmPerVeh * baseFuelEfficiency / 100) * 0.0000347 / 0.7;

            // Fuel if only population changed
            const fuelWithPop = (data.population * baseCarsPerCapita * baseKmPerVeh * baseFuelEfficiency / 100) * 0.0000347 / 0.7;
            const popEffect = fuelWithPop - baselineFuel;

            // Fuel if population + ownership changed
            const fuelWithOwnership = (data.population * data.cars_per_capita * baseKmPerVeh * baseFuelEfficiency / 100) * 0.0000347 / 0.7;
            const ownershipEffect = fuelWithOwnership - fuelWithPop;

            // Fuel if pop + ownership + efficiency changed (but no EVs)
            const fuelWithEfficiency = (data.population * data.cars_per_capita * baseKmPerVeh * data.fuel_efficiency_L100km / 100) * 0.0000347 / 0.7;
            const efficiencyEffect = fuelWithEfficiency - fuelWithOwnership;

            // Fuel with EVs (actual forecast)
            const actualEffect = data.total_fuel_demand_tj;
            const evEffect = actualEffect - fuelWithEfficiency;

            fuelFromPopulation.push(popEffect);
            fuelFromOwnership.push(ownershipEffect);
            fuelFromEfficiency.push(efficiencyEffect);
            fuelFromEV.push(evEffect);
            actualFuel.push(actualEffect);
        });

        return {
            labels: years,
            baseYear: baseYear,
            datasets: [
                {
                    label: 'Population Growth',
                    data: fuelFromPopulation,
                    backgroundColor: '#EF5350',
                    stack: 'stack1'
                },
                {
                    label: 'Car Ownership Changes',
                    data: fuelFromOwnership,
                    backgroundColor: '#FFA726',
                    stack: 'stack1'
                },
                {
                    label: 'Fleet Efficiency Improvements',
                    data: fuelFromEfficiency,
                    backgroundColor: '#66BB6A',
                    stack: 'stack1'
                },
                {
                    label: 'EV Adoption',
                    data: fuelFromEV,
                    backgroundColor: '#42A5F5',
                    stack: 'stack1'
                }
            ],
            actualFuel: actualFuel
        };
    }

    getForecastEfficiencyData(countryCode, scenario = 'improvement') {
        /**
         * Get forecast efficiency data with benchmarks
         * Shows forecasted fleet efficiency vs regional benchmarks
         */
        const forecastCountry = this.forecastData[countryCode];
        if (!forecastCountry || !forecastCountry.scenarios || !forecastCountry.scenarios[scenario]) {
            return null;
        }

        const scenarioData = forecastCountry.scenarios[scenario];
        const years = scenarioData.map(d => d.year);
        const fleetEfficiency = scenarioData.map(d => d.fuel_efficiency_L100km);
        const evShare = scenarioData.map(d => d.ev_share * 100); // Convert to percentage

        // Get regional benchmarks for this country
        const benchmarkData = this.fuelBenchmarks[countryCode];
        const region = benchmarkData?.region || 'Europe';

        // Benchmark values (static for forecast - could be improved)
        const suvBenchmark = benchmarkData?.suv_L100 || 10.0;
        const carBenchmark = benchmarkData?.car_L100 || 7.0;

        // Assume 80% EVs as passenger vehicles, 20% as freight
        const evPassengerShare = scenarioData.map(d => d.ev_share * 0.8 * 100);

        return {
            labels: years,
            datasets: [
                {
                    label: 'Forecasted Fleet Average',
                    data: fleetEfficiency,
                    borderColor: '#AB47BC',
                    backgroundColor: 'transparent',
                    borderWidth: 3,
                    fill: false,
                    spanGaps: false,
                    yAxisID: 'y'
                },
                {
                    label: `${region} SUV Benchmark`,
                    data: years.map(() => suvBenchmark),
                    borderColor: '#EF5350',
                    backgroundColor: 'transparent',
                    borderWidth: 2,
                    borderDash: [5, 5],
                    fill: false,
                    yAxisID: 'y'
                },
                {
                    label: `${region} Car Benchmark`,
                    data: years.map(() => carBenchmark),
                    borderColor: '#66BB6A',
                    backgroundColor: 'transparent',
                    borderWidth: 2,
                    borderDash: [5, 5],
                    fill: false,
                    yAxisID: 'y'
                },
                {
                    label: 'EV Share (%)',
                    data: evShare,
                    borderColor: '#4FC3F7',
                    backgroundColor: 'rgba(79, 195, 247, 0.1)',
                    borderWidth: 2,
                    fill: true,
                    yAxisID: 'y1',
                    spanGaps: false
                }
            ],
            region: region
        };
    }
}
