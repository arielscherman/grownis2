import { Controller } from "stimulus"
import ApexCharts from 'apexcharts'

export default class extends Controller {
  static targets = [ "placeholder" ]
  colors = {
    primary: "#004a99",
    secondary: "#ff0d49"
  }

  connect() {
    var options = {
      chart: {
        height: 380,
        width: "100%",
        type: "line",
        fontFamily: 'Overpass, sans-serif'
      },
      grid: { show: false },
      colors: [this.colors.primary, this.colors.secondary],
      series: JSON.parse(this.data.get('series')),
      xaxis: {
        categories: JSON.parse(this.data.get('categories'))
      },
      yaxis: [{
        title: {
          text: this.data.get('titleCurrency'),
          style: {
            color: this.colors.primary
          }
        },
        labels: {
          style: {
            colors: this.colors.primary
          }
        }
      }, {
        title: {
          text: this.data.get('titleRate'),
          style: {
            color: this.colors.secondary
          }
        },
        opposite: true,
        labels: {
          style: {
            colors: this.colors.secondary
          }
        }
      }]
    };

    var chart = new ApexCharts(this.placeholderTarget, options);

    chart.render();
  }
}
