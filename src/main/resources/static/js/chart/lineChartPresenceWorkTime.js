var lineChartAPI = Vue.resource( '/chartData/getChartDataPresenceWorkTime/{subdivision}');

var subdivisionID = 0;

if (typeof subdivisionParam !== 'undefined') {
    subdivisionID = subdivisionParam;
}

Vue.component('line-chart', {
    extends: VueChartJs.Line,
    mounted () {
        lineChartAPI.get({subdivision: subdivisionID}).then(result =>
            result.json().then(data => {
                    this.datasets = data;
                console.log(this.datasets)
                    this.renderChart({
                            type: 'line',
                            labels: ['Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота', 'Воскресенье'],
                            datasets: this.datasets
                        }, {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                yAxes: [{
                                    ticks: {
                                        min: 0,
                                        max: 12,
                                        stepSize: 1
                                    }
                                }]
                            }
                        }
                    )
                }
            )
        )
    },
    data:function() {
        return {
            datasets: []
        }
    }
})

var vm = new Vue({
    el: '#lineChartPresenceWorkTime'
})