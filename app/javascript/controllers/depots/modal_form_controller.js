import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "currencySelect", "rateSelect", "rateSelectPlaceholder" ]

  connect() {
    new Choices(this.currencySelectTarget, { searchPlaceholderValue: "Busca una moneda", position: "bottom" })
    this.rateChoices = new Choices(this.rateSelectTarget, { searchPlaceholderValue: "Busca un valor de referencia", position: "bottom" })
    this.currencySelectTarget.addEventListener('choice', event => { this._onCurrencyChange(event.detail.choice.value) });
  }

  _onCurrencyChange(selectedCurrencyId) {
    this._hideRatePlaceholder();
    if(selectedCurrencyId) {
      this._fetchRates(selectedCurrencyId);
    }
    this._resetRateChoices();
  }

  _fetchRates(currencyId) {
    fetch(this.data.get('ratesUrl') + `?currency_id=${currencyId}`).then(response => response.json()).then(rates => {
      if(rates.length > 0) {
        const parsedRates = rates.map((rate, i) => { return { value: rate.id, label: rate.name, selected: rates.length == 1 } })
        this.rateChoices.setChoices(parsedRates, 'value', 'label', true).enable();
        this._showRatePlaceholder();
      }
    })
  }

  _hideRatePlaceholder() {
    this.rateSelectPlaceholderTarget.classList.add('ui-placeholder-disabled');
  }

  _showRatePlaceholder() {
    this.rateSelectPlaceholderTarget.classList.remove('ui-placeholder-disabled');
  }

  _resetRateChoices() {
    this.rateChoices.clearChoices().clearInput().setValue([]).clearStore().disable();
  }
}
