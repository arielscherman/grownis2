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
        type: "area",
        fontFamily: 'Overpass, sans-serif',
        toolbar: { show: false },
      },
      grid: { show: false },
      stroke: {
        curve: "smooth"
      },
      colors: [this.colors.primary, this.colors.secondary],
      series: JSON.parse(this.data.get('series')),
      xaxis: {
        categories: JSON.parse(this.data.get('categories'))
      },
      yaxis: this._buildTitles()
    };

    var chart = new ApexCharts(this.placeholderTarget, options);

    chart.render();
  }

  _buildTitles() {
    var titles = [this._buildTitle(this.data.get('titleCurrency'), this.colors.primary)]

    if(this.data.get('titleRate')) {
      titles = titles.concat(this._buildTitle(this.data.get('titleRate'), this.colors.secondary, true))
    }

    return titles
  }

  _buildTitle(title, color, opposite=false) {
    return {
      title: {
        text:  title,
        style: { color: color }
      },
      opposite: opposite,
      labels: {
        formatter: function(value) {
          return value.toLocaleString('es-AR', { style: 'decimal' })
        },
        style: {
          colors: color
        }
      }
    }
  }
}
