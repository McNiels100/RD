import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="brand-device"
export default class extends Controller {
  static targets = ["brand", "deviceType"]

  connect() {
    this.toggleDeviceType()
  }

  toggleDeviceType() {
    if (this.brandTarget.value) {
      this.deviceTypeTarget.style.display = "" // Show
    } else {
      this.deviceTypeTarget.style.display = "none" // Hide
    }
  }

  brandChanged() {
    this.toggleDeviceType()
  }
}
