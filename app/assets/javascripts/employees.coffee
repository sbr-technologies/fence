# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

 hide_show_login_fields = () ->
   if $('#employee_need_login').prop('checked')
     $('.login_fields').show()
   else
     $('.login_fields').hide()

 $('#employee_need_login').click ->
  hide_show_login_fields();

 hide_show_login_fields();

 $('#employees').dataTable({
    "order": [[ 1, "asc" ], [2, "asc"], [3, "asc"]],
    "aoColumnDefs": [
      { 'bSortable': false, 'aTargets': [ 4,5 ] }
    ]
  })

 #if $('#employee_password').length > 0
  # $('#employee_password').rules 'add',
   #  messages: required: 'Password is required'
    # required:
     #  depends: (element) ->
      #   $('#employee_need_login').is(':checked') and is_new_record == 'true'
#
 #  $('#employee_email').rules 'add',
  #   messages: required: 'Employee Email is required'
   #  required:
    #   depends: (element) ->
     #    $('#employee_need_login').is(':checked')
