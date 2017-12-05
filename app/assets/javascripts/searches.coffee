# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  searchFormDiv = $('.search_field')
  previousQuery = searchFormDiv.data('previous-query')
  $('#search_query').val(previousQuery)

  fillFormWithProposal = (query) ->
    ->
      $('#search_query').val(query)
      $('#new_search').submit()

  $('.proposal_query').each ->
    $(this).on 'click', fillFormWithProposal($(this).html().trim())
