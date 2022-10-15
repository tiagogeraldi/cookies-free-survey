// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'bootstrap'
import Masonry from 'masonry-layout'
import ClipboardJS from 'clipboard'

document.addEventListener('turbo:load', (event) => {
  new ClipboardJS('.clipboard');

  if (document.querySelector('.masonry-grid')) {
    new Masonry( '.masonry-grid', {})
  }
})
