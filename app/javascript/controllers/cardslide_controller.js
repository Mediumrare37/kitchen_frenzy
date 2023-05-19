import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="cardslide"
export default class extends Controller {
  connect() {
  }

  updateCard() {
    console.log("Hello");
    if (window.scrollY >= (window.innerHeight / 2)) {
      this.element.classList.add("animate__fadeInLeft");
    } else {
      this.element.classList.remove("animate__fadeInLeft");
    }
  }
}
