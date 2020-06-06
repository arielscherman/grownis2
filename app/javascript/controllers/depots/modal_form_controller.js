import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "currencySelect" ]

  connect() {
    new Choices(this.currencySelectTarget, { searchPlaceholderValue: "Busca una moneda" })
  }
}
