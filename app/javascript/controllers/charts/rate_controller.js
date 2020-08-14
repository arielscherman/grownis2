import { Controller } from "stimulus"
import ApexCharts from 'apexcharts'

export default class extends Controller {
  static targets = [ "placeholder" ]
  colors = { primary: "#4e5bf2" }

  connect() {
    var options = {
      chart: {
        height: 380,
        width: "100%",
        type: "line",
        fontFamily: 'Overpass, sans-serif',
        toolbar: { show: false },
      },
      grid: { show: false },
      stroke: {
        curve: "smooth"
      },
      dataLabels: { enabled: false },
      colors: [this.colors.primary],
      series: JSON.parse(this.data.get('series')),
      xaxis: {
        categories: JSON.parse(this.data.get('categories'))
      },
    };

    var chart = new ApexCharts(this.placeholderTarget, options);

    chart.render();
  }
}
