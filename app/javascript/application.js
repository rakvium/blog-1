// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"


window.dispatchMapsEvent = function (...args) {
  const event = document.createEvent("Events")
  event.initCustomEvent("google-maps-callback", true, true)
  event.args = args
  window.dispatchEvent(event)
}