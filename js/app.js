// Main application
import { DataManager } from './dataManager.js';
import { ChartsManager } from './charts.js';

class App {
    constructor() {
        this.dataManager = new DataManager();
        this.chartsManager = new ChartsManager();

        this.currentIndicator = 'total';
        this.currentYear = 2023;
        this.valueType = 'absolute';
        this.baseYear = 2010;
        this.selectedCountry = null;
        this.currentSort = 'value-desc';
        this.kayaMode = 'indexed';
        this.oilMode = 'absolute';
        this.evMode = 'absolute';
        this.rawDataMode = 'absolute';
        this.ownershipMetric = 'per_capita'; // 'per_capita' or 'total'
        this.currentView = 'raw'; // 'raw', 'efficiency', or 'forecast'
        this.efficiencyScenario = 'improvement'; // 'improvement' or 'age_out'

        this.init();
    }

    async init() {
        try {
            // Show loading
            document.getElementById('loading').classList.remove('hidden');

            console.log('Loading data...');
            // Load data
            await this.dataManager.loadAll();
            console.log('Data loaded successfully');

            // Setup controls
            this.setupControls();

            // Initial render
            this.updateCountryList();

            // Hide loading
            document.getElementById('loading').classList.add('hidden');

            console.log('App initialized successfully');

        } catch (error) {
            console.error('Failed to initialize app:', error);
            console.error('Error details:', error.message, error.stack);
            document.getElementById('loading').innerHTML = `
                <div class="spinner"></div>
                <p style="color: #ff6b6b;">Error: ${error.message}</p>
                <p style="font-size: 12px; color: #888;">Check console for details</p>
            `;
        }
    }

    setupControls() {
        // Setup year slider
        const yearSlider = document.getElementById('year-slider');
        const yearValue = document.getElementById('year-value');
        const years = this.dataManager.getYears();

        if (yearSlider && yearValue) {
            // Set slider range
            const minYear = Math.min(...years);
            const maxYear = Math.max(...years);
            yearSlider.min = minYear;
            yearSlider.max = maxYear;
            yearSlider.value = this.currentYear;
            yearValue.textContent = this.currentYear;

            // Year slider change
            yearSlider.addEventListener('input', (e) => {
                this.currentYear = parseInt(e.target.value);
                yearValue.textContent = this.currentYear;
                this.updateCountryList();
                if (this.selectedCountry) {
                    this.updateCharts();
                }
            });
        }

        // Setup base year slider
        const baseYearSlider = document.getElementById('base-year-slider');
        const baseYearValue = document.getElementById('base-year-value');
        if (baseYearSlider && baseYearValue) {
            const minYear = Math.min(...years);
            const maxYear = Math.max(...years);
            baseYearSlider.min = minYear;
            baseYearSlider.max = maxYear;
            baseYearSlider.value = this.baseYear;
            baseYearValue.textContent = this.baseYear;

            // Base year slider change
            baseYearSlider.addEventListener('input', (e) => {
                this.baseYear = parseInt(e.target.value);
                baseYearValue.textContent = this.baseYear;
                this.updateCountryList();
                if (this.selectedCountry) {
                    this.updateCharts();
                }
            });
        }

        // Indicator (product) change
        const indicatorSelect = document.getElementById('indicator-select');
        if (indicatorSelect) {
            indicatorSelect.addEventListener('change', (e) => {
                this.currentIndicator = e.target.value;
                this.updateCountryList();
            });
        }

        // Sort change
        const sortSelect = document.getElementById('sort-select');
        if (sortSelect) {
            sortSelect.addEventListener('change', (e) => {
                this.currentSort = e.target.value;
                this.updateCountryList();
            });
        }

        // Value type change
        const valueTypeSelect = document.getElementById('value-type-select');
        if (valueTypeSelect) {
            valueTypeSelect.addEventListener('change', (e) => {
                this.valueType = e.target.value;

                // Show/hide base year selector based on value type
                const baseYearControl = document.getElementById('base-year-control');
                if (baseYearControl) {
                    if (this.valueType === 'indexed') {
                        baseYearControl.style.display = 'block';
                    } else {
                        baseYearControl.style.display = 'none';
                    }
                }

                this.updateCountryList();
            });
        }

        // Close detail panel
        const closeDetail = document.getElementById('close-detail');
        if (closeDetail) {
            closeDetail.addEventListener('click', () => {
                this.closeDetail();
            });
        }

        // Chart mode selects (only if they exist)
        const rawDataModeSelect = document.getElementById('raw-data-mode-select');
        if (rawDataModeSelect) {
            rawDataModeSelect.addEventListener('change', (e) => {
                this.rawDataMode = e.target.value;
                if (this.selectedCountry && this.currentView === 'raw') {
                    this.updateRawDataView();
                }
            });
        }

        const oilModeSelect = document.getElementById('oil-mode-select');
        if (oilModeSelect) {
            oilModeSelect.addEventListener('change', (e) => {
                this.oilMode = e.target.value;
                if (this.selectedCountry && this.currentView === 'raw') {
                    this.updateRawDataView();
                }
            });
        }

        const evModeSelect = document.getElementById('ev-mode-select');
        if (evModeSelect) {
            evModeSelect.addEventListener('change', (e) => {
                this.evMode = e.target.value;
                if (this.selectedCountry && this.currentView === 'vehicle-market') {
                    this.updateVehicleMarketView();
                }
            });
        }

        // Ownership metric select (for efficiency view)
        const ownershipMetricSelect = document.getElementById('ownership-metric-select');
        if (ownershipMetricSelect) {
            ownershipMetricSelect.addEventListener('change', (e) => {
                this.ownershipMetric = e.target.value;
                if (this.selectedCountry && this.currentView === 'efficiency') {
                    this.updateEfficiencyView();
                }
            });
        }

        // Efficiency scenario select (for forecast view)
        const efficiencyScenarioSelect = document.getElementById('efficiency-scenario-select');
        if (efficiencyScenarioSelect) {
            efficiencyScenarioSelect.addEventListener('change', (e) => {
                this.efficiencyScenario = e.target.value;
                if (this.selectedCountry && this.currentView === 'forecast') {
                    this.updateForecastView();
                }
            });
        }

        // View toggle buttons
        document.querySelectorAll('.toggle-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const view = e.target.dataset.view;
                this.currentView = view;

                // Update active state
                document.querySelectorAll('.toggle-btn').forEach(b => b.classList.remove('active'));
                e.target.classList.add('active');

                // Show/hide appropriate chart containers
                this.switchChartView(view);

                // Update charts based on view
                if (this.selectedCountry) {
                    this.updateCharts();
                }
            });
        });
    }

    switchChartView(view) {
        // Hide all chart views
        document.querySelectorAll('.charts-view').forEach(el => el.classList.add('hidden'));

        // Show the selected view
        const viewId = `charts-${view}`;
        const viewElement = document.getElementById(viewId);
        if (viewElement) {
            viewElement.classList.remove('hidden');
        }
    }

    updateCountryList() {
        const data = this.dataManager.getHeatmapData(
            this.currentIndicator,
            this.currentYear,
            null,
            this.valueType,
            this.valueType === 'indexed' ? this.baseYear : null
        );

        // Sort data
        const sortedData = this.sortData(data);

        // Render country list
        const listContainer = document.getElementById('country-list');
        listContainer.innerHTML = '';

        sortedData.forEach(item => {
            const countryName = this.dataManager.getCountryName(item.country);
            const countryItem = document.createElement('div');
            countryItem.className = 'country-item';
            if (this.selectedCountry === item.country) {
                countryItem.classList.add('selected');
            }

            countryItem.innerHTML = `
                <span class="country-name">${countryName}</span>
                <span class="country-value">${this.formatValue(item.value)}</span>
            `;

            countryItem.addEventListener('click', () => {
                this.showCountryDetail(item.country);
            });

            listContainer.appendChild(countryItem);
        });
    }

    sortData(data) {
        const sorted = [...data];

        switch (this.currentSort) {
            case 'name-asc':
                sorted.sort((a, b) => {
                    const nameA = this.dataManager.getCountryName(a.country);
                    const nameB = this.dataManager.getCountryName(b.country);
                    return nameA.localeCompare(nameB);
                });
                break;
            case 'name-desc':
                sorted.sort((a, b) => {
                    const nameA = this.dataManager.getCountryName(a.country);
                    const nameB = this.dataManager.getCountryName(b.country);
                    return nameB.localeCompare(nameA);
                });
                break;
            case 'value-asc':
                sorted.sort((a, b) => a.value - b.value);
                break;
            case 'value-desc':
            default:
                sorted.sort((a, b) => b.value - a.value);
                break;
        }

        return sorted;
    }

    formatValue(value) {
        if (this.valueType === 'indexed') {
            return value.toFixed(1);
        }

        // Format based on indicator type
        const kayaVariables = ['population', 'cars_per_pop', 'km_per_veh', 'gasoline_per_km', 'gasoline_total'];

        if (kayaVariables.includes(this.currentIndicator)) {
            switch (this.currentIndicator) {
                case 'population':
                    return (value / 1000000).toFixed(2) + 'M';
                case 'cars_per_pop':
                    return value.toFixed(3);
                case 'km_per_veh':
                    return (value / 1000).toFixed(1) + 'K km';
                case 'gasoline_per_km':
                    return (value * 1000000).toFixed(2) + ' TJ/Mkm';
                case 'gasoline_total':
                    return (value / 1000).toFixed(1) + 'K TJ';
                default:
                    return value.toFixed(2);
            }
        } else {
            // Oil consumption formatting
            if (value >= 1000000) {
                return (value / 1000000).toFixed(2) + 'M TJ';
            } else if (value >= 1000) {
                return (value / 1000).toFixed(1) + 'K TJ';
            } else {
                return value.toFixed(0) + ' TJ';
            }
        }
    }

    showCountryDetail(countryCode) {
        this.selectedCountry = countryCode;
        const countryName = this.dataManager.getCountryName(countryCode);

        // Update selected state in list
        document.querySelectorAll('.country-item').forEach(item => {
            item.classList.remove('selected');
        });
        event.currentTarget?.classList.add('selected');

        // Update country name
        document.getElementById('country-name').textContent = countryName;

        // Make sure raw view is shown by default
        this.switchChartView(this.currentView);

        // Update charts
        this.updateCharts();

        // Show panel
        document.getElementById('detail-panel').classList.remove('hidden');
    }

    updateCharts() {
        if (!this.selectedCountry) return;

        console.log('Updating charts - view:', this.currentView, 'kayaMode:', this.kayaMode, 'oilMode:', this.oilMode, 'evMode:', this.evMode);

        if (this.currentView === 'raw') {
            this.updateRawDataView();
        } else if (this.currentView === 'efficiency') {
            this.updateEfficiencyView();
        } else if (this.currentView === 'forecast') {
            this.updateForecastView();
        } else if (this.currentView === 'vehicle-market') {
            this.updateVehicleMarketView();
        }
    }

    updateRawDataView() {
        const rawDataMetrics = this.dataManager.getRawDataMetrics(this.selectedCountry);
        const derivedFeatures = this.dataManager.getDerivedFeatures(this.selectedCountry);
        const oilData = this.dataManager.getOilConsumptionTimeSeries(
            this.selectedCountry,
            this.oilMode === 'indexed',
            this.baseYear
        );

        console.log('Raw data metrics:', rawDataMetrics);
        console.log('Derived features:', derivedFeatures);

        this.chartsManager.updateRawDataChart(rawDataMetrics);
        this.chartsManager.updateDerivedFeaturesChart(derivedFeatures);
        this.chartsManager.updateOilProductsChart(oilData, this.oilMode === 'indexed');
    }

    updateVehicleMarketView() {
        const evData = this.dataManager.getEVData(this.selectedCountry, this.evMode);
        const categoryData = this.dataManager.getVehicleCategoryData(this.selectedCountry);
        const vehicleTypeMixData = this.dataManager.getVehicleTypeMixData(this.selectedCountry);

        console.log('EV data:', evData);
        console.log('Category data:', categoryData);
        console.log('Vehicle type mix data:', vehicleTypeMixData);

        this.chartsManager.updateEVChart(evData);
        this.chartsManager.updateCategoryMixChart(categoryData);
        this.chartsManager.updateVehicleTypeMixChart(vehicleTypeMixData);
    }

    updateEfficiencyView() {
        // Get fuel saved data
        const fuelSavedData = this.dataManager.getFuelSavedData(
            this.selectedCountry,
            this.baseYear,
            this.ownershipMetric
        );

        // Get efficiency trends data
        const efficiencyTrendsData = this.dataManager.getEfficiencyTrendsData(
            this.selectedCountry
        );

        console.log('Fuel saved data:', fuelSavedData);
        console.log('Efficiency trends data:', efficiencyTrendsData);

        // Update charts
        this.chartsManager.updateFuelSavedChart(fuelSavedData);
        this.chartsManager.updateEfficiencyTrendsChart(efficiencyTrendsData);
    }

    updateForecastView() {
        // Get forecast demand decomposition data
        const forecastDemandData = this.dataManager.getForecastDemandData(this.selectedCountry, this.efficiencyScenario);

        // Get forecast efficiency data
        const forecastEfficiencyData = this.dataManager.getForecastEfficiencyData(this.selectedCountry, this.efficiencyScenario);

        console.log('Forecast demand data:', forecastDemandData);
        console.log('Forecast efficiency data:', forecastEfficiencyData);

        // Update charts
        this.chartsManager.updateForecastDemandChart(forecastDemandData);
        this.chartsManager.updateForecastEfficiencyChart(forecastEfficiencyData);
    }

    closeDetail() {
        document.getElementById('detail-panel').classList.add('hidden');
        this.selectedCountry = null;

        // Remove selected state from all items
        document.querySelectorAll('.country-item').forEach(item => {
            item.classList.remove('selected');
        });
    }
}

// Start the app when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => new App());
} else {
    new App();
}
