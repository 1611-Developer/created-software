import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  close() {
    document.getElementById("modal").innerHTML = ""
  }
}

