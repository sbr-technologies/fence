# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#lookup_types').change ->
    $('.ajax_loader').show();
    $.get('lookup_items.js', {selected_option: $(this).val()}, 'script');
