# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  show_link = $ '#show-checkboxes'
  show_link.click (e) ->
    e.preventDefault()
    show_link.hide()
    ($ '#checkboxes').slideDown()