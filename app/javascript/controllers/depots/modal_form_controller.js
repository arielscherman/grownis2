import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "currencySelect", "rateSelect", "rateSelectPlaceholder" ]

  connect() {
    new Choices(this.currencySelectTarget, { searchPlaceholderValue: "Busca una moneda" })
    this.rateChoices = new Choices(this.rateSelectTarget, { searchPlaceholderValue: "Busca un valor de referencia" })
    this.currencySelectTarget.addEventListener('choice', event => { this._onCurrencyChange(event.detail.choice.value) });
  }

  _onCurrencyChange(selectedCurrencyId) {
    this._hideRatePlaceholder();
    if(selectedCurrencyId > 0) {
      this._fetchRates(selectedCurrencyId);
    }
    this._resetRateChoices();
  }

  _fetchRates(currencyId) {
    fetch(this.data.get('ratesUrl') + `?currency_id=${currencyId}`).then(response => response.json()).then(rates => {
      if(rates.length > 0) {
        const parsedRates = rates.map((rate, i) => { return { value: rate.id, label: rate.name, selected: i == 0 } })
        this.rateChoices.setChoices(parsedRates, 'value', 'label', true).enable();
        this._showRatePlaceholder();
      }
    })
  }

  _hideRatePlaceholder() {
    this.rateSelectPlaceholderTarget.classList.add('ui-hidden');
  }

  _showRatePlaceholder() {
    this.rateSelectPlaceholderTarget.classList.remove('ui-hidden');
  }

  _resetRateChoices() {
    this.rateChoices.clearChoices().clearInput().setValue([]).clearStore().disable();
  }
}
