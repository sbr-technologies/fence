# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
#  projectTable = $("#projects").dataTable({
#    "order": [[ 1, "asc" ]],
#    "aoColumnDefs": [
#      { 'bSortable': false, 'aTargets': [ 0,4 ] }
#    ],
#    "bLengthChange": false,
#    sAjaxSource: $('#projects').data('source')
#    initComplete: (settings, json) ->
#      $('.view_projects_list_name'). on 'click', (event)->
#        $(this).next('.edit_projects_list_name').show().end().hide()
#  })
#  
#  $('body'). on 'click', '.cancel_projects_list_name', (event)->
#    $(this).parent().prev('.view_projects_list_name').show().end().hide()
  
#  $('#searchProject').on 'keyup', (event)->
#    projectTable.fnFilter($(this).val())
  
#  projectTable.on 'draw', (event)->
#    body = $( projectTable.table().body() )
#    body.unhighlight()
#    body.highlight( projectTable.search() )

  $("#project_products_dt").dataTable({
    "aaSorting": [[ 1, "desc" ]],
    "aoColumnDefs": [
      { 'bSortable': false, 'aTargets': [ 0,5,6 ] }
    ]
  })

  $MAX_OPTION_CAN_SELECT = 30

  $('#product_list').multiselect({
    maxHeight: 200,
    buttonWidth: '400px',
    enableCaseInsensitiveFiltering: true
    includeSelectAllOption: false,
    onChange: (option, checked) ->
      selectedOptions = $('#product_list option:selected')
      if selectedOptions.length >= $MAX_OPTION_CAN_SELECT
        nonSelectedOptions = $('#product_list option').filter(->
          !$(this).is(':selected')
        )
        dropdown = $('#product_list').siblings('.multiselect-container')
        nonSelectedOptions.each ->
          `var dropdown`
          input = $('#product_selection_div input[value="' + $(this).val() + '"]')
          input.prop 'disabled', true
          input.parent('li').addClass 'disabled'
      else
        dropdown = $('#product_list').siblings('.multiselect-container')
        $('#product_list option').each ->
          value = $(this).val()
          if jQuery.inArray(value, $added_product_ids) == -1
            input = $('#product_selection_div input[value="' + value + '"]')
            input.prop 'disabled', false
            input.parent('li').addClass 'disabled'
  });

  if typeof $added_product_ids != 'undefined'

    if $added_product_ids.length == 0
      $('#header').hide()

    disable_option = (product_id) ->
      input = $('#product_selection_div input[value="' + product_id + '"]')
      input.prop 'disabled', true
      input.parent('li').addClass 'disabled'

    enable_option = (product_id) ->
      input = $('#product_selection_div input[value="' + product_id + '"]')
      input.prop 'disabled', ''
      input.parent('li').removeClass 'disabled'

    $.each $added_product_ids, (index, product_id) ->
      $('#product_list').multiselect 'select', product_id
      disable_option(product_id)


    $('#add_products').click (e) ->
      e.preventDefault()
      options_selected = $('#product_list option:checked')
      if options_selected.length > $MAX_OPTION_CAN_SELECT
        alert('Please reduce number of option selected to less than or equal to '+$MAX_OPTION_CAN_SELECT+'!!');
        return
      $.each options_selected, (index, value) ->
        $('#header').show()
        if jQuery.inArray(value.value, $added_product_ids) == -1
          $('.add_nested_fields').click()
          $('.fields:last .unit_of_measurement_id').val $(value).data('unit_of_measurement_id')
          $('.fields:last .product_name').text value.text
          $('.fields:last .name_field').val value.text
          $('.fields:last .product_field').val value.value
          $('.fields:last .retail_price').val $(value).data('retail_price')
          $('.fields:last .amount').autoNumeric('init');
          $('.fields:last input:visible').each ->
            $(this).rules 'add', messages: required: $(this).data('attr-name')
          disable_option(value.value)
          $added_product_ids.push value.value

    $(document).on 'nested:fieldRemoved', (event) ->
      product_id = event.field.find('.product_field').val()
      $('#product_list').multiselect 'deselect', product_id
      $added_product_ids.splice $.inArray(product_id, $added_product_ids), 1
      enable_option(product_id)
      if $added_product_ids.length == 0
        $('#header').hide()

#  $('#projects .checkAll').change ->
#      status = this.checked
#      boxes = $('#projects input[type="checkbox"]:not(.checkAll)')
#      $("#deleteSelectedProjects").attr("disabled", !status)
#      boxes.each (i, elem) =>
#        elem.checked = status
#        return
#    $('#projects input[type="checkbox"]:not(.checkAll)').change ->
#      num = $('#projects input[type="checkbox"]:not(.checkAll)').filter(':not(:checked)').length # shows not checked num
#      if num == 0
#        $('#projects .checkAll')[0].checked = true
#      else if num > 0
#        $('#projects .checkAll')[0].checked = false
#      num2 = $('#projects input[type="checkbox"]:not(.checkAll)').filter(':checked').length # shows checked num
#      if num2 == 0
#        $("#deleteSelectedProjects").attr("disabled", true) # To disable "delete all" button
#      else if num2 > 0
#        $("#deleteSelectedProjects").attr("disabled", false) # To enable "delete all" button