import { Controller } from "stimulus"
import ApexCharts from 'apexcharts'

export default class extends Controller {
  static targets = [ "placeholder" ]

  colors = { primary: "#727cf5" }

  connect() {
    var options = {
      chart: {
        height: this._isMinimalStyle() ? 60 : 400,
        type: "area",
        fontFamily: 'Overpass, sans-serif',
        toolbar: { show: false },
        sparkline: {
          enabled: this._isMinimalStyle()
        }
      },
      legend: { show: true },
      stroke: {
        width: 2,
        curve: "smooth"
      },
      grid: { 
        show: false,
        xaxis: {
          lines: { show: !this._isMinimalStyle() }
        },
        yaxis: {
          lines: { show: !this._isMinimalStyle() }
        }
      },
      colors: [this.colors.primary],
      series: JSON.parse(this.data.get('series')),
      dataLabels: { enabled: false },
      xaxis: {
        categories: JSON.parse(this.data.get('categories')),
        labels: { show: !this._isMinimalStyle() },
        tooltip: { enabled: false }
      },
      yaxis: {
        labels: { show: !this._isMinimalStyle() }
      }
    };

    var chart = new ApexCharts(this.placeholderTarget, options);

    chart.render();
  }

  _isMinimalStyle() {
    return this.data.get('chartType') == 'minimal'
  }
}
