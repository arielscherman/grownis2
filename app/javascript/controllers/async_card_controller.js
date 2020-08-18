import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  connect() {
    this.element.addEventListener('should-refresh', () => { this._refreshContent() })
    this._fetchContent()
  }

  _fetchContent() {
    Rails.ajax({
      type: 'GET',
      url: this._url()
    })
  }

  _refreshContent() {
    this.element.innerHTML = this._spinnerHtml()
    this._fetchContent()
  }

  _spinnerHtml() {
    "<div clss='ui-loading'><i class='ui-spinner'></i><p class='ui-spin'>Cargando</p></div>"
  }

  _url() {
    const url           = this.data.get('url')
    const placeholderId = this.data.get('placeholderId')

    if(url.includes('?')) {
      return `${url}&placeholder_id=${placeholderId}`
    } else {
      return `${url}?placeholder_id=${placeholderId}`
    }
  }
}
