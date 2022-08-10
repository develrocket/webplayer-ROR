class @Main

  form_submit_result: (formSelector) ->

    $(formSelector).on("ajax:success", (e, data, status, xhr) ->

      # iframe reload
      iframe = document.getElementById('interior_iframe')
      if iframe
        iframe.src = iframe.src;

      tempHtml = """
        <div class='alert alert-info custom-alert-margin'>
          #{data.name}
        </div>
      """
      $('div.result-notice').fadeIn().html(tempHtml)

      window.setTimeout ( ->
        $('div.result-notice').fadeOut().html('');

        return
      ), 3000

    ).on("ajax:error", (e, data, status, xhr) ->
      $(formSelector).render_form_errors('admin', data.responseJSON)
    )

  read_url: (input, wrapClass) ->
    if input.files && input.files[0]
      ext = $(input).val().split('.').pop().toLowerCase()

      if $.inArray(ext, ['gif','png','jpg','jpeg']) == -1
        alert 'invalid extension!'
        return false

      reader = new FileReader();

      reader.onload = (e) ->
        $('div.' + wrapClass + ' img').attr('src', e.target.result);

      reader.readAsDataURL(input.files[0])

  # remove image event
  remove_image_tour: (path, type, tour_id, currentObj) ->

    $.ajax path,
      type: "POST",
      dataType: "JSON",
      data:
        tour_id: tour_id
        type: type
      asnyc: false,
      success: (data) ->
        currentObj.parent().find('img').attr('src', data.default_image_src).attr('alt', 'Image is removed')
        currentObj.removeAttr('data-id')
        currentObj.parent().removeClass('image-uploaded')

$.fn.render_form_errors = (model_name, errors) ->
  form = this
  this.clear_form_errors()

  $.each(errors, (field, messages) ->
    split_fields = field.split('.')
    if split_fields.length > 1
      model_name = split_fields[0]
      field = split_fields[1]
    input = form.find('input, select, textarea').filter(->
      name = $(this).attr('name')
      if name
        name.match(new RegExp(model_name + '\\[' + field + '\\(?'))
    )
    input.closest('.form-group').addClass('has-error')
    input.parent().append('<span class="help-block">' + $.map(messages, (m) -> m.charAt(0).toUpperCase() + m.slice(1)).join('<br />') + '</span>')
  )
  return

$.fn.clear_form_errors = () ->
  this.find('.form-group').removeClass('has-error')
  this.find('span.help-block').remove()

$.fn.clear_form_fields = () ->
  this.find(':input','#myform')
  .not(':button, :submit, :reset, :hidden')
  .val('')
  .removeAttr('checked')
  .removeAttr('selected')