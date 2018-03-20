# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("#products").dataTable({
    "order": [[ 1, 'asc']]
    "aoColumnDefs": [
      { 'bSortable': false, 'aTargets': [ 5,6 ] }
    ]
    sAjaxSource: $('#products').data('source')
  })


  if $('#product_product_name').length > 0
    $('#cost_price').autoNumeric('init')
    $('#retail_price').autoNumeric('init')
    $('#cost_price').rules 'add',
      messages: max: 'must be less than or equal to retail price'
      max: depends: (element) ->
        cost_price = $('#cost_price').autoNumeric('get')
        retail_price = $('#retail_price').autoNumeric('get')
        cost_price = parseFloat(cost_price)
        retail_price = parseFloat(retail_price)
        cost_price > retail_price

