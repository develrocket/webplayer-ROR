# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require bootstrap-spinner
#= require backend/client/visitor
#= require backend/client/statistic

main = new Main()
ready = ->
  if $('th.user-profile').length
    $('.clients-table').dataTable({
      "iDisplayLength": -1,
      "aoColumns":[
        {"bSortable": true},
        {"bSortable": true},
        {"bSortable": false},
        {"bSortable": true},
        {"bSortable": true},
        {"bSortable": false}
      ]
      responsive: true
    });
  else
    $('.clients-table').dataTable({ responsive: true })

  # scroll down to tab for user experience
#  if gon.scroll
#    $("html, body").animate({ scrollTop: $("ul.nav-tabs").offset().top - 50 }, 1000);

  # agent branding page avatar load image function
  $("input#agent_branding_avatar").change ->
    main.read_url(this, 'avatar-preview')

  add_detach()

  return

add_detach = ->
  $('a.add-detach').click (e)->
    e.preventDefault()
    tmpHtml = """
      <div class='detach-row'>
        <div class='col-md-4'>
          <input name='detach_unit_address[]' placeholder='Address' id='detach_unit_address' class='form-control m-b'>
        </div>
        <div class='col-md-7'>
          <input name='detach_unit_link[]' placeholder='Link' id='detach_unit_link' class='form-control m-b'>
        </div>
        <div class='col-md-1'>
          <button type='button' class='btn btn-danger btn-sm' onclick='delete_detach_unit(this)'>
            <i class='color-danger fa fa-trash-o'></i>
          </button>
        </div>
      </div>
      """
    $('div.detach-wrap').append(tmpHtml)
  return

root = exports ? this
root.delete_detach_unit = (obj) ->
  $(obj).closest('.detach-row').remove()


$(document).ready(ready);
#$(document).on('page:load', ready);

class @WebplayerBasic
  constructor: ->
    @_initialize()

  _initialize: ->
    # webplayer basic page switch plugin
    elem = document.querySelector('.js-switch1');
    switchery1 = new Switchery(elem, { color: '#1AB394' });
    elem = document.querySelector('.js-switch2');
    switchery2 = new Switchery(elem, { color: '#1AB394' });

    # webplayer basic page load brand image function
    $("input#webplayer_basic_brand").change ->
      main.read_url(this, 'brand-preview')

    # webplayer basic page load media photo image function
    $("input#webplayer_basic_media").change ->
      main.read_url(this, 'media-preview')

    #webplayer basic page brand show or hide on off event
    $('.js-switch1').change ->
      if !switchery1.isChecked()
        $('input#webplayer_basic_brand').parent().attr('disabled', true)
      else $('input#webplayer_basic_brand').parent().removeAttr('disabled')
    $('.js-switch1').change() # will need for page load event

    #webplayer basic page media show or hide on off event
    $('.js-switch2').change ->
      if !switchery2.isChecked()
        $('input#webplayer_basic_media').parent().attr('disabled', true)
      else $('input#webplayer_basic_media').parent().removeAttr('disabled')
    $('.js-switch2').change() # will need for page load event

    # remove image event
    $('a.remove-avatar').click (e) ->
      thisObj = $(this)
      e.preventDefault()

      if thisObj.parent().hasClass('brand-preview')
        type = 'webplayer_brand'
      else type = 'webplayer_media'

      tour_id = $(this).data('id')
      main.remove_image_tour(gon.remove_image_path, type, tour_id, thisObj)

class @TourBranding
  constructor: ->
    @_initialize()

  _initialize: ->
# webplayer basic page switch plugin
    elem = document.querySelector('.js-switch1');
    switchery1 = new Switchery(elem, { color: '#1AB394' });

    # webplayer basic page load brand image function
    $("input#tour_branding_logo").change ->
      main.read_url(this, 'logo-preview')

    #webplayer basic page brand show or hide on off event
    $('.js-switch1').change ->
      if !switchery1.isChecked()
        $('input#tour_branding_logo').parent().attr('disabled', true)
      else $('input#tour_branding_logo').parent().removeAttr('disabled')
    $('.js-switch1').change() # will need for page load event

    $('a.remove-avatar').click (e) ->
      thisObj = $(this)
      e.preventDefault()

      type = 'tour_branding'

      tour_id = $(this).data('id')
      main.remove_image_tour(gon.remove_image_path, type, tour_id, thisObj)

class @TourOwnership
  constructor: ->
    @_initialize()

  _initialize: ->
    $('select#tour_admin_id').change ->
      thisObj = $(this)
      admin_id = $(this).val()

      $.ajax gon.tour_get_admin_by_id,
        type: "POST",
        dataType: "JSON",
        data:
          admin_id: admin_id
        asnyc: false,
        success: (data) ->
          $('input#tour_is_tour_branding').prop('checked', data.admin.tour_branding)
          $('input#tour_is_agent_branding').prop('checked', data.admin.agent_branding)
          $('input#tour_is_display_contents').prop('checked', data.admin.display_contents)
          $('input#tour_is_restriction_option').prop('checked', data.admin.restriction_option)
          $('input#tour_is_data_log').prop('checked', data.admin.data_log)
          $('input#tour_is_statistic').prop('checked', data.admin.statistic)