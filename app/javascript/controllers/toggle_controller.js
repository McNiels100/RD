import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleable"];
  static classes = ["hidden"];

  connect() {}

  toggle() {
    // Toggle visibility
    this.toggleableTarget.classList.toggle(this.hiddenClass);

    // If we're showing the modal, reload the inventory frame if any
    if (!this.toggleableTarget.classList.contains(this.hiddenClass)) {
      // Reset the inventory_select frame
      const frame = document.getElementById("inventory_select");
      if (frame) frame.src = frame.src;
    }
  }
}
