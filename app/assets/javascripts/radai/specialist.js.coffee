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

  specialists = $ '.specialist-card'
  specialists_data = _.map specialists, (sp) ->
    sp = $ sp
    id: sp.data('id'), slug: sp.data('slug')

  get_fb_stats = (sp) ->
    url = "https://api.facebook.com/method/fql.query?query=select%20like_count,comment_count,share_count%20from%20link_stat%20where%20url='#{gon.specialist_url_prefix}/#{sp.id}/#{sp.slug}'&format=json"
    $.get url, (data) ->
      update_specialist_card sp, data

  update_specialist_card = (sp, data) ->
    data = data[0]
    update_and_show ".likes-#{sp.id}", ".like-count", data.like_count
    update_and_show ".comments-#{sp.id}", ".comment-count", data.comment_count

  update_and_show = (item, container, value) ->
    if value > 0
      item = $ item
      item.text value
      item.parents(container).show()

  _.each specialists_data, (sp) ->
    get_fb_stats sp

  address_input = $ '#specialist_full_address'
  latitude_input = $ '#specialist_latitude'
  longitude_input = $ '#specialist_longitude'
  profile_map = $ '#profile-map'
  geocoder = null
  unless typeof(google) is 'undefined'
    geocoder = new google.maps.Geocoder()

  if profile_map.length
    # Checkbox limit
    selector = "input[type=checkbox][name=specialist\\[extra_services_select\\]\\[\\]]"
    $(selector).click ->
      setTimeout ->
        $(selector).not(":checked").attr "disabled", $("#{selector}:checked").length >= 5
      , 1

  process_results = (results, status) ->
    if status == google.maps.GeocoderStatus.OK
      loc = results[0].geometry.location
      if profile_map.length
        profile_map.slideDown()
        Gmaps.loadMaps()
        map = Gmaps.map.serviceObject
        Gmaps.map.clearMarkers()
        marker = new google.maps.Marker
          draggable: true,
          map: map,
          position: loc
        google.maps.event.addListener marker, 'dragend', ->
          loc = this.getPosition()
          latitude_input.val loc.lat()
          longitude_input.val loc.lng()

        map.setCenter loc
      latitude_input.val loc.lat()
      longitude_input.val loc.lng()

    else if status == google.maps.GeocoderStatus.ZERO_RESULTS
      profile_map.slideUp() if profile_map.length
    else
      console.log("Geocode was not successful for the following reason: " + status);

  # update map after input is typed
  update_map = ->
    return if typeof(google) is 'undefined'
    if address_input.val().length > 0
      geocoder ||= new google.maps.Geocoder()
      geocoder.geocode address: address_input.val(), (results, status) ->
        process_results results, status
    else
      profile_map.slideUp()

  address_input.keyup (e) ->
    latitude_input.val ''
    longitude_input.val ''
    clearTimeout address_timeout
    address_timeout = setTimeout update_map, 1000

