# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $("#manufacturers").dataTable({
    "order": [[ 1, "asc" ]],
    "aoColumnDefs": [
      { 'bSortable': false, 'aTargets': [ 2,3 ] }
    ]
  })

