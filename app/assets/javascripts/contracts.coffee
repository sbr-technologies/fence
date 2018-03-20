#jQuery ->
#  $("#contracts").dataTable({
#    "order": [[ 0, "desc" ]],
#    "aoColumnDefs": [
#      { 'bSortable': false, 'aTargets': [ 6,7 ] }
#    ]
#  })
#
#  $MAX_OPTION_CAN_SELECT = 30
#
#  $('#project_list').multiselect({
#    maxHeight: 200,
#    buttonWidth: '400px',
#    enableCaseInsensitiveFiltering: true
#    includeSelectAllOption: false
#  });
#
#  if typeof $added_project_ids != 'undefined'
#    if $added_project_ids.length == 0
#      $('#header').hide()
#
#    disable_option = (project_id) ->
#      input = $('#project_selection_div input[value="' + project_id + '"]')
#      input.prop 'disabled', true
#      input.parent('li').addClass 'disabled'
#
#    enable_option = (project_id) ->
#      input = $('#project_selection_div input[value="' + project_id + '"]')
#      input.prop 'disabled', ''
#      input.parent('li').removeClass 'disabled'
#
#    $.each $added_project_ids, (index, project_id) ->
#      $('#project_list').multiselect 'select', project_id
#      disable_option(project_id)
#
#    $('#add_projects').click (e) ->
#      e.preventDefault()
#      options_selected = $('#project_list option:checked')
#      if options_selected.length > $MAX_OPTION_CAN_SELECT
#        alert('Please reduce number of option selected to less than or equal to '+$MAX_OPTION_CAN_SELECT+'!!');
#        return
#      $.each options_selected, (index, value) ->
#        $('#header').show()
#        if jQuery.inArray(value.value, $added_project_ids) == -1
#          $('.add_nested_fields').click()
#          $field = $('.fields:last')
#          $field.find('.name').text value.text
#          $field.find('.copy_project_id').val value.value
#          $field.find('.description').text $(value).data('desc')
#          $field.find('.category_name').text $(value).data('cat_name')
#          $field.find('.unit_of_measurement_id').val $(value).data('unit_of_measurement_id')
#
#          #Remove Manage Link for newly added projects
#          $field.find('.manage_project_link').remove()
#
#          #Disable option in select box
#          disable_option(value.value)
#          $added_project_ids.push value.value
#
#    $(document).on 'nested:fieldRemoved', (event) ->
#      project_id = event.field.find('.copy_project_id').val()
#      $('#project_list').multiselect 'deselect', project_id
#      $added_project_ids.splice $.inArray(project_id, $added_project_ids), 1
#      enable_option(project_id)
#      if $added_project_ids.length == 0
#        $('#header').hide()
