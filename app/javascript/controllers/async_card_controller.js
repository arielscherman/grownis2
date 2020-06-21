import { Controller } from "stimulus"
import Rails from "@rails/ujs";

export default class extends Controller {
  connect() {
    const url           = this.data.get('url')
    const placeholderId = this.data.get('placeholderId')

    Rails.ajax({
      type: 'GET',
      url: `${url}?placeholder_id=${placeholderId}`
    })
  }
}
