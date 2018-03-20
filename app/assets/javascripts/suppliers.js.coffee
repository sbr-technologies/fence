jQuery ->
  $("#suppliers").dataTable({
    "aoColumnDefs": [
      { 'bSortable': false, 'aTargets': [ 1,2 ] }
    ]
  })
