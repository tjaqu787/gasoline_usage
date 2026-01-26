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
        this.baseYear = 2000;
        this.selectedCountry = null;
        this.currentSort = 'value-desc';
        this.kayaMode = 'indexed';
        this.oilMode = 'absolute';
        this.evMode = 'absolute';

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

        // Set slider range
        const minYear = Math.min(...years);
        const maxYear = Math.max(...years);
        yearSlider.min = minYear;
        yearSlider.max = maxYear;
        yearSlider.value = this.currentYear;
        yearValue.textContent = this.currentYear;

        // Setup base year slider
        const baseYearSlider = document.getElementById('base-year-slider');
        const baseYearValue = document.getElementById('base-year-value');
        baseYearSlider.min = minYear;
        baseYearSlider.max = maxYear;
        baseYearSlider.value = this.baseYear;
        baseYearValue.textContent = this.baseYear;

        // Indicator (product) change
        document.getElementById('indicator-select').addEventListener('change', (e) => {
            this.currentIndicator = e.target.value;
            this.updateCountryList();
        });

        // Sort change
        document.getElementById('sort-select').addEventListener('change', (e) => {
            this.currentSort = e.target.value;
            this.updateCountryList();
        });

        // Value type change
        document.getElementById('value-type-select').addEventListener('change', (e) => {
            this.valueType = e.target.value;

            // Show/hide base year selector based on value type
            const baseYearControl = document.getElementById('base-year-control');

            if (this.valueType === 'indexed') {
                baseYearControl.style.display = 'block';
            } else {
                baseYearControl.style.display = 'none';
            }

            this.updateCountryList();
        });

        // Base year slider change
        baseYearSlider.addEventListener('input', (e) => {
            this.baseYear = parseInt(e.target.value);
            baseYearValue.textContent = this.baseYear;
            this.updateCountryList();
            if (this.selectedCountry) {
                this.updateCharts();
            }
        });

        // Year slider change
        yearSlider.addEventListener('input', (e) => {
            this.currentYear = parseInt(e.target.value);
            yearValue.textContent = this.currentYear;
            this.updateCountryList();
            if (this.selectedCountry) {
                this.updateCharts();
            }
        });

        // Close detail panel
        document.getElementById('close-detail').addEventListener('click', () => {
            this.closeDetail();
        });

        // Chart mode selects
        document.getElementById('kaya-mode-select').addEventListener('change', (e) => {
            this.kayaMode = e.target.value;
            if (this.selectedCountry) {
                this.updateCharts();
            }
        });

        document.getElementById('oil-mode-select').addEventListener('change', (e) => {
            this.oilMode = e.target.value;
            if (this.selectedCountry) {
                this.updateCharts();
            }
        });

        document.getElementById('ev-mode-select').addEventListener('change', (e) => {
            this.evMode = e.target.value;
            if (this.selectedCountry) {
                this.updateCharts();
            }
        });
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

        // Update charts
        this.updateCharts();

        // Show panel
        document.getElementById('detail-panel').classList.remove('hidden');
    }

    updateCharts() {
        if (!this.selectedCountry) return;

        console.log('Updating charts - kayaMode:', this.kayaMode, 'oilMode:', this.oilMode, 'evMode:', this.evMode);

        // Get data for oil products chart
        const oilData = this.dataManager.getOilConsumptionTimeSeries(
            this.selectedCountry,
            this.oilMode === 'indexed',
            this.baseYear
        );

        // Get data for Kaya chart
        const kayaData = this.dataManager.getKayaData(
            this.selectedCountry,
            this.kayaMode === 'indexed',
            this.baseYear
        );

        // Get data for EV chart
        const evData = this.dataManager.getEVData(
            this.selectedCountry,
            this.evMode
        );

        console.log('Oil data sample:', oilData?.datasets[0]?.data?.slice(0, 3));
        console.log('Kaya data sample:', kayaData?.datasets[0]?.data?.slice(0, 3));
        console.log('EV data sample:', evData?.datasets[0]?.data?.slice(0, 3));

        // Update charts
        this.chartsManager.updateOilProductsChart(oilData, this.oilMode === 'indexed');
        this.chartsManager.updateKayaChart(kayaData, this.kayaMode === 'indexed');
        this.chartsManager.updateEVChart(evData);
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
