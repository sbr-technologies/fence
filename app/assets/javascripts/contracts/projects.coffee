jQuery ->
  $('.container').on 'focusout', '.change_price', (e) ->
    $field = $(this).closest('.fields')
    quantity = $field.find('.quantity').val()
    retail_price = $field.find('.retail_price').autoNumeric('get');
    labor_hour = $field.find('.labor_hour').val()
    labor_rate = parseFloat $field.find('.labor_rate').autoNumeric('get');
    $field.find('.total_price').val(quantity * retail_price)
    $field.find('.total_amount').val(quantity * retail_price + labor_rate * labor_hour)
