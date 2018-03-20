jQuery ->
  if $('form').length>1
    $('#new_user').validate()
    $('#signin_account').validate()
  else if $('form').hasClass('ng_validation') == false
    $('form').validate()
  $.validator.addMethod 'decimal', ((value, element) ->
            /^\d{0,100}(\.\d{0,2})?$/i.test(value)
          ), two_decimal_allowed

  $.validator.addMethod 'integer', ((value, element) ->
            /^\d{0,100}?$/i.test(value)
          ), no_decimal_allowed

  $.validator.addMethod 'phone_field', ((phone_number, element) ->
        regex = /^(\+1)?\s?((\()[0-9]{3}\)|([0-9]{3}))(-|\s)?[0-9]{3}(-|\s)?[0-9]{4}$/
        @optional(element) or phone_number.length > 9 and phone_number.match(regex)
      ), invalid_phone_number

  jQuery.validator.addMethod 'zipcode', ((value, element) ->
        @optional(element) or /^\d{5}(?:-\d{4})?$/.test(value)
      ), invalid_zip

  jQuery.validator.addMethod 'phone_ext', ((value, element) ->
        @optional(element) or /^\d{0,6}$/.test(value)
      ), invalid_phone_ext

  jQuery.validator.addMethod 'letters_only', ((value, element) ->
        @optional(element) or /^[a-z]+$/i.test(value)
      ), 'Letters only please'

  jQuery.validator.addMethod 'greaterThan', ((value, element, params) ->
        if !/Invalid|NaN/.test(new Date(value)) && !/Invalid|NaN/.test(new Date($(params).val()))
          new Date(value) > new Date($(params).val())
        else
          return true
      ), 'must be after start date'

#  $('input.form-control:visible, select').each ->
#    $(this).rules 'add', messages: required: $(this).data('attr-name')

  $.validator.addClassRules
    float:
      number: true
      decimal: true
      max: 10000000000
    integer:
      number: true
      integer: true
      max: 10000000000
    phone_field:
      phone_field: true
    zipcode:
      zipcode: true
    phone_ext:
      phone_ext: true
    letters_only:
      letters_only: true
    end_date:
      greaterThan: ".start_date"
