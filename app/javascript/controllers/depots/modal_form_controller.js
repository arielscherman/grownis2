import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "currencySelect", "rateSelect" ]

  connect() {
    new Choices(this.currencySelectTarget, { searchPlaceholderValue: "Busca una moneda" })
    new Choices(this.rateSelectTarget, { searchPlaceholderValue: "Busca un valor de referencia" })
  }
}
