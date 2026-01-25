// Charts Manager using Chart.js
export class ChartsManager {
    constructor() {
        this.oilProductsChart = null;
        this.kayaChart = null;
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
}
