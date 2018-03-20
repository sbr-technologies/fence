jQuery ->
  $('.date').datepicker
    showOn: 'button'
    buttonImage: calendar_path,
    buttonImageOnly: true,
    autoclose: true,
    showOn: "button"

  $('.amount').autoNumeric('init');

  call_geocomplete = (target) ->
    $(target).geocomplete().bind 'geocode:result', (event, result) ->
      data = {}
      $.each result.address_components, (index, object) ->
        name = object.types[0]
        $.each object.types, (index, name) ->
          data[name] = object.long_name
          data[name + '_short'] = object.short_name
  
  
      $target = $(event.target).closest('.details')
      component = ['locality', 'administrative_area_level_1','country', 'postal_code']
      $.each component, (index, name) ->
        $target.find('.' + name).val data[name]
      if data['postal_code_suffix']
        $postal_code = $target.find('.postal_code')
        $postal_code.val($postal_code.val() + '-' + data['postal_code_suffix'])
      addr = data['route']
      if data['street_number']
        addr = data['street_number'] + ', ' + addr
      $target.find('.formatted_address').val addr

  $(document).on "nested:fieldAdded", (event) ->
    call_geocomplete('.search_address:last');

  call_geocomplete('.search_address');

  $(document).on "change", '.is_primary',(event) ->
    val = !$(this).is(':checked');
    $('.is_primary').prop('checked', false)
    $(this).prop('checked', !val);

  $(document).on "change", '.is_primary_phone',(event) ->
    val = !$(this).is(':checked');
    $('.is_primary_phone').prop('checked', false)
    $(this).prop('checked', !val);

  $(document).on "change", '.is_primary_contact',(event) ->
    val = !$(this).is(':checked');
    $('.is_primary_contact').prop('checked', false)
    $(this).prop('checked', !val);

  window.navigating = true
  $('body').on 'submit', 'form', ->
    window.navigating = false
    return

  window.onbeforeunload = ->
    $form = $('form')
    if $form.length > 0 && $form.attr('action') && $form.attr('method') == 'post' && window.navigating
      return ''
    return

  $.rails.allowAction = (link) ->
    if typeof link.attr('data-confirm') == 'undefined'
      return true 
    else
      $.rails.showConfirmDialog(link)
      return false
         
  $.rails.confirmed = (link) ->
    link.removeAttr('data-confirm')
    if link.attr('data-method') 
      link.trigger('click')
    else
      link.trigger('click.rails')

  $.rails.showConfirmDialog = (link) ->
    message = link.attr 'data-confirm'
    $('#confirmationDialog').modal('show')

    $('#confirmationDialog .confirm').unbind('click')
    $('#confirmationDialog .confirm').click ->
      $.rails.confirmed(link)

  $('.dropdown-menu').on "click", "input", (event) ->
    event.stopPropagation()