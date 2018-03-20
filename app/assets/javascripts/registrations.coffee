jQuery ->
  if $('#password_confirmation').length > 0
    $('#password').rules 'add',
      minlength: 6

    $('#password_confirmation').rules 'add',
      messages: equalTo: password_do_not_match
      equalTo: '#password'

    $('#organization_name').rules 'add',
      remote:
        url: '/unique_business_name'
        type: 'get'
      messages: remote: 'has already been taken'


    $('#admin_email').rules 'add',
      remote:
        url: '/unique_admin_email'
        type: 'get'
      messages: remote: 'has already been taken'


  $('#password').strength({strengthMeterClass: 'strength_meter pull-right'})
