# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require underscore-min
#= require gmaps/google
#= require bootstrap-datepicker
#= require 'plugins/switchery/switchery'
#= require backend/client/statistic

switchery3 = undefined

ready = ->

  # access approve event when click approve button in data log page
  $("button#approve_access").unbind('click').click ->
    thisObj = $(this)
    thisObj.text('Processing...')
    request = $.ajax "/backend/visitors_log/approve_visitor_access",
      type: 'POST',
      data: { visitor_id: $(this).data('visitor_id') },
      dataType: 'json'
    request.done (data) ->
      if data
        tmpHtml = '<span class="label label-primary">Approved Access</span>'
        thisObj.parent().html(tmpHtml)
    request.fail (jqXHR, textStatus) ->
      console.log(textStatus)

  # load visitor location map
  $("a.visitor-location").click (e) ->
    lat = $(this).data('lat')
    lon = $(this).data('lon')
    $("div.map-modal").modal('show')
    $('div.map-modal').on 'shown.bs.modal', ->
      define_map(lat, lon)
      return

  # show modal for approved email lists
  $("a#load_approved_emails_modal").click (e)->
    e.preventDefault()
    href = $(this).attr("href")
    $.get href, (message, status) ->
      $("div.approved-modal-container").html(message)
      $('div#approved_email_modal').modal('show')

  # show visitor data log in data log
  $('a.data-log-detail').unbind('click').click (e) ->
    e.preventDefault()
    $.get $(this).attr('href'), (message, status) ->
      if $('div.visitor-detail').length == 0
        bootbox.dialog
          title: 'Visitor Detail'
          message: message
          buttons: success:
            label: 'Close'
            className: 'btn-success'
            callback: ->

      return
    return

  return
define_map = (lat, lon) ->
  handler = Gmaps.build('Google')

  handler.buildMap({ provider: {}, internal: {id: 'map'}}, ->
    markers = handler.addMarkers([
      {
        "lat": Number(lat),
        "lng": Number(lon),
        "infowindow": "hello!"
      }
    ])
    handler.bounds.extendWith(markers)
    handler.fitMapToBounds()
    handler.getMap().setZoom(14)
  )
$(document).ready(ready);
$(document).on('page:load', ready);

class @RestrictOption
  constructor: ->
    @_initialize()

  _initialize: ->
# Restrict Option page switch plugin
    elem = document.querySelector('.js-switch3');
    switchery3 = new Switchery(elem, { color: '#1AB394' });

    # restrict options page restrict option change event
    # 4 step confirmation relative event 1 < 2 < 3 < 4
    $('input#restrict_option_email_confirmation').change ->
      if $(this).prop('checked') == true
        $('input#restrict_option_email').prop 'checked', true
        checkRestrictionOption()
      else
        $('input#restrict_option_agent_approval').prop('checked', false).change()
      return
    $('input#restrict_option_agent_approval').change ->
      if $(this).prop('checked') == true
        $('input#restrict_option_email_confirmation').prop('checked', true).change()
      else
        $('input#restrict_option_send_inquire').prop 'checked', false
        checkRestrictionOption()
      return
    $('input#restrict_option_send_inquire').change ->
      if $(this).prop('checked') == true
        $('input#restrict_option_agent_approval').prop('checked', true).change()
      else
        checkRestrictionOption()
      return
    $('input#restrict_option_email').change ->
      if $(this).prop('checked') == false
        $('input#restrict_option_email_confirmation').prop('checked', false).change()
      else
        checkRestrictionOption()
      return

    $('input#restrict_option_name, input#restrict_option_message, input#restrict_option_phone').change ->
      checkRestrictionOption()

    # restrict options page on off switch event
    $('.js-switch3').change ->
      if !switchery3.isChecked()
        # if switch is off, all items should be unchecked
        $('ul.restrict_options li').each (index, obj) ->
          $(obj).find('input[type=checkbox]').prop 'checked', false
          return
      else
        reset_position = true
        $('ul.restrict_options li').each (index, obj) ->
          if $(obj).find('input[type=checkbox]').prop 'checked'
            restrict_checked = false

        # there is no checked item, it should be unchecked
        switchery3.setPosition reset_position
      return

#  check switch will enable or not.
checkRestrictionOption = ->
  checked = false
  $('ul.restrict_options li').each (index, obj) ->
    if $(obj).find('input[type=checkbox]').prop('checked') == true
      checked = true
    return
  if switchery3.isChecked() == true and !checked
    switchery3.setPosition true
  else if switchery3.isChecked() == false and checked
    switchery3.setPosition true
  return