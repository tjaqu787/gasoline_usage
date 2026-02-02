// Charts Manager using Chart.js
export class ChartsManager {
    constructor() {
        this.oilProductsChart = null;
        this.kayaChart = null;
        this.evChart = null;
        this.rawDataChart = null;
        this.derivedFeaturesChart = null;
        this.categoryMixChart = null;
        this.fuelSavedChart = null;
        this.efficiencyTrendsChart = null;
    }

    updateOilProductsChart(data, indexed = false) {
        const canvas = document.getElementById('oil-products-chart');
        const ctx = canvas.getContext('2d');

        if (this.oilProductsChart) {
            this.oilProductsChart.destroy();
        }

        if (!data) {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = '#888';
            ctx.font = '14px sans-serif';
            ctx.textAlign = 'center';
            ctx.fillText('No oil consumption data available', canvas.width / 2, canvas.height / 2);
            return;
        }

        const yAxisTitle = indexed ? `Index (${data.baseYear} = 100)` : 'TJ (Terajoules)';
        const tooltipSuffix = indexed ? '' : ' TJ';

        this.oilProductsChart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: true,
                scales: {
                    x: {
                        stacked: true,
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' }
                    },
                    y: {
                        stacked: true,
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' },
                        title: {
                            display: true,
                            text: yAxisTitle,
                            color: '#e0e0e0'
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: { color: '#e0e0e0', boxWidth: 15, font: { size: 11 } }
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#4fc3f7',
                        bodyColor: '#e0e0e0',
                        borderColor: '#4fc3f7',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    if (indexed) {
                                        label += context.parsed.y.toFixed(1);
                                    } else {
                                        label += context.parsed.y.toLocaleString() + tooltipSuffix;
                                    }
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });
    }

    updateKayaChart(data, indexed = true) {
        const canvas = document.getElementById('kaya-chart');
        const ctx = canvas.getContext('2d');

        if (this.kayaChart) {
            this.kayaChart.destroy();
        }

        if (!data) {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = '#888';
            ctx.font = '14px sans-serif';
            ctx.textAlign = 'center';
            ctx.fillText('No identity data available for this country', canvas.width / 2, canvas.height / 2);
            ctx.fillText('(requires population, vehicle, and km driven data)', canvas.width / 2, canvas.height / 2 + 20);
            return;
        }

        const baseYear = data.baseYear;

        // Configure scales based on mode
        let scales;
        if (indexed) {
            // Single Y-axis for indexed values (all components on same scale)
            scales = {
                x: {
                    grid: { color: 'rgba(255, 255, 255, 0.1)' },
                    ticks: { color: '#e0e0e0' }
                },
                y: {
                    type: 'linear',
                    display: true,
                    position: 'left',
                    grid: { color: 'rgba(255, 255, 255, 0.1)' },
                    ticks: { color: '#e0e0e0' },
                    title: {
                        display: true,
                        text: `Index (${baseYear} = 100)`,
                        color: '#e0e0e0'
                    }
                }
            };
        } else {
            // Multiple Y-axes for absolute values
            scales = {
                x: {
                    grid: { color: 'rgba(255, 255, 255, 0.1)' },
                    ticks: { color: '#e0e0e0' }
                },
                y: {
                    type: 'linear',
                    display: true,
                    position: 'left',
                    grid: { color: 'rgba(255, 255, 255, 0.1)' },
                    ticks: { color: '#e0e0e0' },
                    title: { display: true, text: 'Population (M)', color: '#e0e0e0' }
                },
                y1: {
                    type: 'linear',
                    display: true,
                    position: 'right',
                    grid: { drawOnChartArea: false },
                    ticks: { color: '#e0e0e0' },
                    title: { display: true, text: 'Cars/Pop', color: '#e0e0e0' }
                },
                y2: {
                    type: 'linear',
                    display: false,
                    position: 'right'
                },
                y3: {
                    type: 'linear',
                    display: false,
                    position: 'right'
                },
                y4: {
                    type: 'linear',
                    display: false,
                    position: 'right'
                }
            };
        }

        const chartTitle = indexed
            ? `gasoline = pop × cars/pop × km/veh × gasoline/km (indexed to ${baseYear})`
            : `gasoline = pop × cars/pop × km/veh × gasoline/km`;

        this.kayaChart = new Chart(ctx, {
            type: 'line',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: true,
                interaction: {
                    mode: 'index',
                    intersect: false,
                },
                scales: scales,
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: { color: '#e0e0e0', boxWidth: 15, font: { size: 10 } }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.9)',
                        titleColor: '#4fc3f7',
                        bodyColor: '#e0e0e0',
                        borderColor: '#4fc3f7',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += context.parsed.y.toFixed(indexed ? 1 : 2);
                                }
                                return label;
                            }
                        }
                    },
                    title: {
                        display: true,
                        text: chartTitle,
                        color: '#e0e0e0',
                        font: { size: 12, style: 'italic' }
                    }
                },
                elements: {
                    line: { tension: 0.3, borderWidth: 2 },
                    point: { radius: 2, hoverRadius: 4 }
                }
            }
        });
    }

    updateEVChart(data) {
        const canvas = document.getElementById('ev-chart');
        const ctx = canvas.getContext('2d');

        if (this.evChart) {
            this.evChart.destroy();
        }

        if (!data) {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = '#888';
            ctx.font = '14px sans-serif';
            ctx.textAlign = 'center';
            ctx.fillText('No EV stock data available for this country', canvas.width / 2, canvas.height / 2);
            return;
        }

        const isShare = data.mode === 'share';
        const chartType = isShare ? 'bar' : 'line';

        this.evChart = new Chart(ctx, {
            type: chartType,
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: true,
                scales: {
                    x: {
                        stacked: isShare,
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' }
                    },
                    y: {
                        stacked: isShare,
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' },
                        title: {
                            display: true,
                            text: isShare ? 'Share (%)' : 'Vehicles',
                            color: '#e0e0e0'
                        },
                        max: isShare ? 100 : undefined
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: { color: '#e0e0e0', boxWidth: 15, font: { size: 11 } }
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#4fc3f7',
                        bodyColor: '#e0e0e0',
                        borderColor: '#4fc3f7',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    if (isShare) {
                                        label += context.parsed.y.toFixed(1) + '%';
                                    } else {
                                        label += context.parsed.y.toLocaleString();
                                    }
                                }
                                return label;
                            }
                        }
                    }
                },
                elements: {
                    line: { tension: 0.3, borderWidth: 2 },
                    point: { radius: 2, hoverRadius: 4 }
                }
            }
        });
    }

    updateRawDataChart(data) {
        const canvas = document.getElementById('raw-data-chart');
        const ctx = canvas.getContext('2d');

        if (this.rawDataChart) {
            this.rawDataChart.destroy();
        }

        if (!data) {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = '#888';
            ctx.font = '14px sans-serif';
            ctx.textAlign = 'center';
            ctx.fillText('No raw data available for this country', canvas.width / 2, canvas.height / 2);
            return;
        }

        this.rawDataChart = new Chart(ctx, {
            type: 'line',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: true,
                interaction: {
                    mode: 'index',
                    intersect: false,
                },
                scales: {
                    x: {
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' }
                    },
                    y: {
                        type: 'linear',
                        display: true,
                        position: 'left',
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' },
                        title: { display: true, text: 'Population (M)', color: '#e0e0e0' }
                    },
                    y1: {
                        type: 'linear',
                        display: true,
                        position: 'right',
                        grid: { drawOnChartArea: false },
                        ticks: { color: '#e0e0e0' },
                        title: { display: true, text: 'Vehicles (M)', color: '#e0e0e0' }
                    },
                    y2: {
                        type: 'linear',
                        display: false,
                        position: 'right'
                    },
                    y3: {
                        type: 'linear',
                        display: false,
                        position: 'right'
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: { color: '#e0e0e0', boxWidth: 15, font: { size: 10 } }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.9)',
                        titleColor: '#4fc3f7',
                        bodyColor: '#e0e0e0',
                        borderColor: '#4fc3f7',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += context.parsed.y.toFixed(2);
                                }
                                return label;
                            }
                        }
                    }
                },
                elements: {
                    line: { tension: 0.3, borderWidth: 2 },
                    point: { radius: 2, hoverRadius: 4 }
                }
            }
        });
    }

    updateDerivedFeaturesChart(data) {
        const canvas = document.getElementById('derived-features-chart');
        const ctx = canvas.getContext('2d');

        if (this.derivedFeaturesChart) {
            this.derivedFeaturesChart.destroy();
        }

        if (!data) {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = '#888';
            ctx.font = '14px sans-serif';
            ctx.textAlign = 'center';
            ctx.fillText('No derived features available for this country', canvas.width / 2, canvas.height / 2);
            return;
        }

        this.derivedFeaturesChart = new Chart(ctx, {
            type: 'line',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: true,
                interaction: {
                    mode: 'index',
                    intersect: false,
                },
                scales: {
                    x: {
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' }
                    },
                    y: {
                        type: 'linear',
                        display: true,
                        position: 'left',
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' },
                        title: { display: true, text: 'Cars per Capita', color: '#e0e0e0' }
                    },
                    y1: {
                        type: 'linear',
                        display: true,
                        position: 'right',
                        grid: { drawOnChartArea: false },
                        ticks: { color: '#e0e0e0' },
                        title: { display: true, text: 'Km per Vehicle (K)', color: '#e0e0e0' }
                    },
                    y2: {
                        type: 'linear',
                        display: false,
                        position: 'right'
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: { color: '#e0e0e0', boxWidth: 15, font: { size: 10 } }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.9)',
                        titleColor: '#4fc3f7',
                        bodyColor: '#e0e0e0',
                        borderColor: '#4fc3f7',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += context.parsed.y.toFixed(2);
                                }
                                return label;
                            }
                        }
                    }
                },
                elements: {
                    line: { tension: 0.3, borderWidth: 2 },
                    point: { radius: 2, hoverRadius: 4 }
                }
            }
        });
    }

    updateCategoryMixChart(data) {
        const canvas = document.getElementById('category-mix-chart');
        const ctx = canvas.getContext('2d');

        if (this.categoryMixChart) {
            this.categoryMixChart.destroy();
        }

        if (!data) {
            // Hide the container if no data
            const container = document.getElementById('category-mix-container');
            if (container) {
                container.style.display = 'none';
            }
            return;
        }

        // Show the container if we have data
        const container = document.getElementById('category-mix-container');
        if (container) {
            container.style.display = 'block';
        }

        this.categoryMixChart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: true,
                scales: {
                    x: {
                        stacked: true,
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' }
                    },
                    y: {
                        stacked: true,
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' },
                        title: {
                            display: true,
                            text: 'Kilometers (millions)',
                            color: '#e0e0e0'
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: { color: '#e0e0e0', boxWidth: 15, font: { size: 11 } }
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#4fc3f7',
                        bodyColor: '#e0e0e0',
                        borderColor: '#4fc3f7',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += context.parsed.y.toLocaleString() + ' M';
                                }
                                return label;
                            }
                        }
                    }
                }
            }
        });
    }

    updateFuelSavedChart(data) {
        const canvas = document.getElementById('fuel-saved-chart');
        const ctx = canvas.getContext('2d');

        if (this.fuelSavedChart) {
            this.fuelSavedChart.destroy();
        }

        if (!data) {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = '#888';
            ctx.font = '14px sans-serif';
            ctx.textAlign = 'center';
            ctx.fillText('Insufficient data to calculate efficiency gains', canvas.width / 2, canvas.height / 2);
            return;
        }

        this.fuelSavedChart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: true,
                scales: {
                    x: {
                        stacked: true,
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' }
                    },
                    y: {
                        stacked: true,
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' },
                        title: {
                            display: true,
                            text: 'Fuel Saved/Added (TJ)',
                            color: '#e0e0e0'
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: { color: '#e0e0e0', boxWidth: 15, font: { size: 11 } }
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        titleColor: '#4fc3f7',
                        bodyColor: '#e0e0e0',
                        borderColor: '#4fc3f7',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += context.parsed.y.toLocaleString() + ' TJ';
                                }
                                return label;
                            },
                            footer: function(tooltipItems) {
                                let total = 0;
                                tooltipItems.forEach(item => {
                                    total += item.parsed.y || 0;
                                });
                                return 'Total: ' + total.toLocaleString() + ' TJ';
                            }
                        }
                    },
                    title: {
                        display: true,
                        text: `Fuel Savings from Efficiency Gains (baseline: ${data.baseYear})`,
                        color: '#e0e0e0',
                        font: { size: 12 }
                    }
                }
            }
        });
    }

    updateEfficiencyTrendsChart(data) {
        const canvas = document.getElementById('efficiency-trends-chart');
        const ctx = canvas.getContext('2d');

        if (this.efficiencyTrendsChart) {
            this.efficiencyTrendsChart.destroy();
        }

        if (!data) {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = '#888';
            ctx.font = '14px sans-serif';
            ctx.textAlign = 'center';
            ctx.fillText('No efficiency trend data available', canvas.width / 2, canvas.height / 2);
            return;
        }

        this.efficiencyTrendsChart = new Chart(ctx, {
            type: 'line',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: true,
                interaction: {
                    mode: 'index',
                    intersect: false,
                },
                scales: {
                    x: {
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' }
                    },
                    y: {
                        type: 'linear',
                        display: true,
                        position: 'left',
                        grid: { color: 'rgba(255, 255, 255, 0.1)' },
                        ticks: { color: '#e0e0e0' },
                        title: {
                            display: true,
                            text: 'Fuel Consumption (L/100km)',
                            color: '#e0e0e0'
                        }
                    },
                    y1: {
                        type: 'linear',
                        display: true,
                        position: 'right',
                        grid: { drawOnChartArea: false },
                        ticks: { color: '#e0e0e0' },
                        title: {
                            display: true,
                            text: 'EV Penetration (%)',
                            color: '#e0e0e0'
                        },
                        max: 100
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom',
                        labels: { color: '#e0e0e0', boxWidth: 15, font: { size: 10 } }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.9)',
                        titleColor: '#4fc3f7',
                        bodyColor: '#e0e0e0',
                        borderColor: '#4fc3f7',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    if (label.includes('EV')) {
                                        label += context.parsed.y.toFixed(1) + '%';
                                    } else {
                                        label += context.parsed.y.toFixed(2) + ' L/100km';
                                    }
                                }
                                return label;
                            }
                        }
                    },
                    title: {
                        display: true,
                        text: `Fleet Efficiency Trends - Region: ${data.region}`,
                        color: '#e0e0e0',
                        font: { size: 12 }
                    }
                },
                elements: {
                    line: { tension: 0.3, borderWidth: 2 },
                    point: { radius: 2, hoverRadius: 4 }
                }
            }
        });
    }
}
