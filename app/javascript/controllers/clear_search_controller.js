import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  reset(event) {
    const input = document.querySelector('input[name="query"]');
    if (input) input.value = "";
  }
}

