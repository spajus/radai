# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

address_timeout = null
$ ->
  show_link = $ '#show-checkboxes'
  show_link.click (e) ->
    e.preventDefault()
    show_link.hide()
    ($ '#checkboxes').slideDown()

  address_input = $ '#specialist_full_address'
  location_url = address_input.data 'search-url'
  profile_map = $ '#profile-map'

  # update map after input is typed
  update_map = ->
    if address_input.val().length > 0
      $.ajax
        url: location_url
        type: 'put'
        data:
          address: address_input.val()
        success: (res) ->
          profile_map.slideDown()
          Gmaps.loadMaps()
          Gmaps.map.replaceMarkers res.geometry.location
        error: (err) ->
          console.log 'error', err
    else
      profile_map.slideUp()

  if profile_map.length
    address_input.keyup (e) ->
      clearTimeout address_timeout
      address_timeout = setTimeout update_map, 1000

