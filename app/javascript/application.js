// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"
import ClipboardJS from 'clipboard'

document.addEventListener('turbo:load', (event) => {
  var clipboard = new ClipboardJS('.clipboard');
  clipboard.on('success', function(e) {
    e.trigger.innerHTML = '<i class="bi bi-check"/>'

    e.clearSelection();
  });
})
