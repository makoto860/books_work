import { Controller } from "@hotwired/stimulus"

// data-controller="slider"に接続
export default class extends Controller {
  static targets = ["track", "slide"]
  connect() {
    this.index = 0
    this.slideWidth = this.slideTargets[0].offsetWidth

    this.start()
  }

  start() {
    this.timer = setInterval(() => {
      this.next()
    }, 5000)
  }

  next() {
    this.index++

    if (this.index >= this.slideTargets.length) {
      this.index = 0
    }

    this.trackTarget.style.transform =
      `translateX(-${this.slideWidth * this.index}px)`
  }

  disconnect() {
    clearInterval(this.timer)
  }
}
