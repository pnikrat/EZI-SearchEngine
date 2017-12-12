# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  groupingFormDiv = $('.grouping_form')
  number_of_groups = groupingFormDiv.data('nog')
  minimum_similarity = groupingFormDiv.data('sim')
  similarity_stop_condition = groupingFormDiv.data('sim-stop')
  $('#grouping_number_of_groups').val(number_of_groups)
  $('#grouping_minimum_similarity').val(minimum_similarity)
  if similarity_stop_condition
    $('#grouping_similarity_stop_condition_true').prop('checked', true)
    $('#grouping_minimum_similarity').css('border', '2px solid green')
  else
    $('#grouping_similarity_stop_condition_false').prop('checked', true)
    $('#grouping_number_of_groups').css('border', '2px solid green')
