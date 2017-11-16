# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
`
$(document).ready(function() {
  var searchFormDiv = $('.search_field');
  var previousQuery = searchFormDiv.data('previous-query');
  $('#search_query').val(previousQuery);
});
`
