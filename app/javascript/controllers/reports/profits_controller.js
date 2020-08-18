import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "dateRange", "refreshable" ]

  connect() {
    flatpickr(this.dateRangeTarget, { maxDate: 'today', dateFormat: "d/m/Y", defaultDate: [new Date(this.data.get('start-date')), new Date(this.data.get('end-date'))], mode: 'range', locale: 'es', onChange: (dates) => { this._dateRangeChanged(dates) } })
  }

  _dateRangeChanged(dates) {
    if(dates.length == 2) {
      this._updateDatesOnRefreshables(dates[0], dates[1])
      this._notifyRefreshables()
    }
  }

  _updateDatesOnRefreshables(startDate, endDate) {
    startDate = this._dateToString(startDate)
    endDate   = this._dateToString(endDate)

    this.data.set('start-date', startDate)
    this.data.set('end-date', endDate)

    this.refreshableTargets.forEach((el) => {
      el.dataset.asyncCardUrl = this._updateDatesInUrl(el.dataset.asyncCardUrl, startDate, endDate)
    })
  }

  _updateDatesInUrl(previousUrl, startDate, endDate) {
    return previousUrl.replace(/(start_date=).*?(&|$)/,'$1' + startDate + '$2')
                      .replace(/(end_date=).*?(&|$)/,'$1' + endDate + '$2')
  }

  _dateToString(date) {
    return date.toISOString().slice(0,10)
  }

  _notifyRefreshables() {
    const event = document.createEvent("CustomEvent")
    event.initCustomEvent("should-refresh", true, true, null)
    this.refreshableTargets.forEach((el) => { el.dispatchEvent(event) })
  }
}
