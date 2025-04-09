import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Define the target element that will be toggled
  static targets = ["toggleable"];
  // Define optional CSS classes to toggle
  static classes = ["hidden"];

  connect() {}

  toggle() {
    // Toggles the class defined in static classes
    this.toggleableTarget.classList.toggle(this.hiddenClass);
  }
}
