import { Controller } from "stimulus"
import ApexCharts from 'apexcharts'

export default class extends Controller {
  static targets = [ "placeholder" ]

  colors = { primary: "#727cf5" }

  connect() {
    var options = {
      chart: {
        height: 60,
        type: "area",
        fontFamily: 'Overpass, sans-serif',
        toolbar: { show: false },
        sparkline: {
          enabled: true
        }
      },
      stroke: {
        width: 2,
        curve: "smooth"
      },
      grid: { 
        show: false,
        xaxis: {
          lines: { show: false }
        },
        yaxis: {
          lines: { show: false }
        }
      },
      colors: [this.colors.primary],
      series: JSON.parse(this.data.get('series')),
      dataLabels: { enabled: false },
      xaxis: {
        categories: JSON.parse(this.data.get('categories')),
        labels: { show: false },
        tooltip: { enabled: false }
      },
      yaxis: {
        labels: { show: false }
      }
    };

    var chart = new ApexCharts(this.placeholderTarget, options);

    chart.render();
  }
}
