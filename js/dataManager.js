// Data Manager - handles loading and querying oil data
export class DataManager {
    constructor() {
        this.countries = {};
        this.oilConsumption = {};
        this.summary = {};
        this.kayaData = {};
    }

    async loadAll() {
        const [countries, oilConsumption, summary, kayaData] = await Promise.all([
            fetch('data/countries.json').then(r => r.json()),
            fetch('data/oil_consumption.json').then(r => r.json()),
            fetch('data/summary.json').then(r => r.json()),
            fetch('data/kaya_data.json').then(r => r.json())
        ]);

        this.countries = countries;
        this.oilConsumption = oilConsumption;
        this.summary = summary;
        this.kayaData = kayaData;
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
                    backgroundColor: 'rgba(79, 195, 247, 0.1)',
                    yAxisID: 'y',
                    fill: true
                },
                {
                    label: 'Cars/Population',
                    data: years.map(year => (countryData[year].cars_per_pop / baseData.cars_per_pop) * 100),
                    borderColor: '#81C784',
                    backgroundColor: 'rgba(129, 199, 132, 0.1)',
                    yAxisID: 'y',
                    fill: true
                },
                {
                    label: 'Km/Vehicle',
                    data: years.map(year => (countryData[year].km_per_veh / baseData.km_per_veh) * 100),
                    borderColor: '#FFD54F',
                    backgroundColor: 'rgba(255, 213, 79, 0.1)',
                    yAxisID: 'y',
                    fill: true
                },
                {
                    label: 'Gasoline/Km',
                    data: years.map(year => (countryData[year].gasoline_per_km / baseData.gasoline_per_km) * 100),
                    borderColor: '#FF6B6B',
                    backgroundColor: 'rgba(255, 107, 107, 0.1)',
                    yAxisID: 'y',
                    fill: true
                },
                {
                    label: 'Total Gasoline',
                    data: years.map(year => (countryData[year].gasoline_total / baseData.gasoline_total) * 100),
                    borderColor: '#AB47BC',
                    backgroundColor: 'rgba(171, 71, 188, 0.2)',
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
                    backgroundColor: 'rgba(79, 195, 247, 0.1)',
                    yAxisID: 'y',
                    fill: true
                },
                {
                    label: 'Cars/Population (cars per person)',
                    data: years.map(year => countryData[year].cars_per_pop),
                    borderColor: '#81C784',
                    backgroundColor: 'rgba(129, 199, 132, 0.1)',
                    yAxisID: 'y1',
                    fill: true
                },
                {
                    label: 'Km/Vehicle (thousand km/year)',
                    data: years.map(year => countryData[year].km_per_veh / 1000),
                    borderColor: '#FFD54F',
                    backgroundColor: 'rgba(255, 213, 79, 0.1)',
                    yAxisID: 'y2',
                    fill: true
                },
                {
                    label: 'Gasoline/Km (TJ per million km)',
                    data: years.map(year => countryData[year].gasoline_per_km * 1_000_000),
                    borderColor: '#FF6B6B',
                    backgroundColor: 'rgba(255, 107, 107, 0.1)',
                    yAxisID: 'y3',
                    fill: true
                },
                {
                    label: 'Total Gasoline (thousand TJ)',
                    data: years.map(year => countryData[year].gasoline_total / 1000),
                    borderColor: '#AB47BC',
                    backgroundColor: 'rgba(171, 71, 188, 0.2)',
                    yAxisID: 'y4',
                    borderWidth: 3,
                    fill: false
                }
            );
        }

        return { labels: years, datasets, indexed, baseYear };
    }
}
