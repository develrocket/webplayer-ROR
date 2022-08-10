# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require 'plugins/switchery/switchery'
#= require ckeditor/init

main = new Main()
ready = ->

  $('.clients-table').dataTable({
    responsive: true
  })

# change companies showing according to agent account type
changeCompanyWrap = (isShow) ->
  if isShow
    $('div.office-address-wrap').show()
    $('div.office-address-wrap select, div.office-address-wrap input').removeAttr('disabled')

    $('label[for=admin_first_name] span, label[for=admin_last_name] span').hide()
  else
    $('div.office-address-wrap').hide();
    $('div.office-address-wrap select, div.office-address-wrap input').attr('disabled', true)

    $('label[for=admin_first_name] span, label[for=admin_last_name] span').show()

$(document).ready(ready);
#$(document).on('page:load', ready);

class @Admin
  constructor: ->
    @_initialize()

  _initialize: ->

    $('select#agent_info_company_id').change ->
      if $('input.account_type').val() != '1'
        return false
      $.ajax 'company/get' ,
        type: "GET",
        dataType: "JSON",
        data:
          company_id: $(this).val()
        asnyc: false,
        success: (data) ->
          if data != 'failed'
            $('input#company_name').val(data.name)

            if data.logo_url == 'missing.png'
              data.logo_url = '/assets/missing.png'

            $('div.logo-preview img').attr('src', data.logo_url)

    # account type radio event when page load
    if Number($('input.account_type:checked').val()) != 1
      $('select#agent_info_company_id').attr('disabled', true)
      $('div.new-company-wrap input#company_name').removeAttr('disabled')
      $('div.new-company-wrap input#logo').removeAttr('disabled')
      $('div.new-company-wrap input#agent_info_company_id').removeAttr('disabled')
    else
      $('select#agent_info_company_id').removeAttr('disabled')
      $('div.new-company-wrap input#company_name').attr('disabled', true)
      $('div.new-company-wrap input#agent_info_company_id').attr('disabled', true)
      $('div.new-company-wrap input#logo').attr('disabled', true)

    if $('input.account_type:checked').val() == '1'
      changeCompanyWrap(false)
    else
      changeCompanyWrap(true)

    # account type radio change event
    $('input.account_type').change ->
      if Number($(this).val()) != 1
        $('select#agent_info_company_id').attr('disabled', true)
        $('div.new-company-wrap input#company_name').removeAttr('disabled').val('')
        $('div.new-company-wrap input#logo').removeAttr('disabled')
        $('div.new-company-wrap input#agent_info_company_id').removeAttr('disabled').val(0)
        $('div.logo-preview img').attr('src', '').attr('alt', 'No image is uploaded')
      else
        $('select#agent_info_company_id').removeAttr('disabled')
        $('div.new-company-wrap input#company_name').attr('disabled', true)
        $('div.new-company-wrap input#agent_info_company_id').attr('disabled', true)
        $('div.new-company-wrap input#logo').attr('disabled', true)

      if this.checked && $(this).val() == '1'
        changeCompanyWrap(false)
      else
        changeCompanyWrap(true)
      return

    # input image file preview for company logo
    $("input#company_logo").change ->
      main.read_url(this, 'logo-preview')

    # input image file preview for user profile image
    $("input#agent_info_avatar").change ->
      main.read_url(this, 'avatar-preview')

    # account type change when page load
    $('input[type=radio][name="admin[agent_type]"]').each ->
      if $(this).val() == '1' and $(this).is(':checked')
        changeCompanyWrap(false)
      else if $(this).is(':checked')
        changeCompanyWrap(true)

    # send account notification email to client
    $('a.send-notification').click (e) ->
      thisObj = $(this)
      thisObj.text('Please Wait...')
      e.preventDefault()
      admin_id = $(this).data('rel')
      $.ajax 'account_create_notification' ,
        type: "POST",
        dataType: "JSON",
        data:
          admin_id: admin_id
        asnyc: false,
        success: (data) ->
          thisObj.text('Send Account Login Info Email')
          thisObj.parent().find('i').fadeIn('1000', ->
            thisObj.parent().find('i').fadeOut('3500')
          )

    if CKEDITOR.instances['notification_additional_email_content']
      CKEDITOR.instances['notification_additional_email_content'].destroy(true)
    CKEDITOR.replace('notification_additional_email_content')
    # edit notification email content to send
    $('a.edit-notification-email').click (e) ->
      e.preventDefault()
      $('div.ckeditor-wrap').fadeToggle('slow')

    $('div.ckeditor-wrap').hide()

    # remove image event
    $('a.remove-avatar, a.remove-logo').click (e) ->
      thisObj = $(this)
      e.preventDefault()

      if $(this).hasClass('remove-avatar')
        type = 'avatar'
      else type = 'logo'

      admin_id = $(this).data('id')

      $.ajax gon.remove_image_path,
        type: "POST",
        dataType: "JSON",
        data:
          admin_id: admin_id
          type: type
        asnyc: false,
        success: (data) ->
          thisObj.parent().find('img').attr('src', data.default_image_src).attr('alt', 'Image is removed')
          thisObj.removeAttr('data-id')
          thisObj.parent().removeClass('image-uploaded')

class @Notification
  constructor: ->
    @_initialize()

  _initialize: ->
    elem = document.querySelector('.message-checkbox');
    switchery1 = new Switchery(elem, { color: '#1AB394' });