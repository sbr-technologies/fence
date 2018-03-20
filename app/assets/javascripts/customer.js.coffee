jQuery ->
  if $('#customer_name').length > 0
    $('#customer_name').rules 'add',
      messages: required: either_of_name_required
      required:
        depends: (element) ->
          $('#customer_last_name').is(':blank') and $('#customer_first_name').is(':blank')

    $('#customer_first_name').rules 'add',
      messages: required: complete_name_required
      required:
        depends: (element) ->
          $('#customer_last_name').is ':filled'

    $('#customer_last_name').rules 'add',
      messages: required: complete_name_required
      required:
        depends: (element) ->
          $('#customer_first_name').is ':filled'

