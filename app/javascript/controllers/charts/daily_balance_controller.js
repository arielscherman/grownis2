import { Controller } from "stimulus"
import ApexCharts from 'apexcharts'

export default class extends Controller {
  static targets = [ "placeholder" ]

  connect() {
    var options = {
      chart: {
        height: 380,
        width: "100%",
        type: "line"
      },
      colors: ["#FF1654", "#247BA0"],
      series: JSON.parse(this.data.get('series')),
      xaxis: {
        categories: JSON.parse(this.data.get('categories'))
      },
      yaxis: JSON.parse(this.data.get('titles'))
    };

    var chart = new ApexCharts(this.placeholderTarget, options);

    chart.render();
  }
}
