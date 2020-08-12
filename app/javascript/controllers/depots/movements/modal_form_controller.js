import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "totalInput", "depotSelect" ]

  connect() {
    this.setInputFilter(this.totalInputTarget, (value) => { return /^-?\d*[.,]?\d{0,2}$/.test(value) })

    if(this.targets.find("depotSelect")) {
      new Choices(this.depotSelectTarget, { searchPlaceholderValue: "Busca una Billetera" })
    }
  }

  setInputFilter(textbox, inputFilter) {
    ["input", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function(event) {
      textbox.addEventListener(event, function() {
        if (inputFilter(this.value)) {
          this.oldValue = this.value;
          this.oldSelectionStart = this.selectionStart;
          this.oldSelectionEnd = this.selectionEnd;
        } else if (this.hasOwnProperty("oldValue")) {
          this.value = this.oldValue;
          this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
        } else {
          this.value = "";
        }
      });
    });
  }
}
