#= stub active_admin/lib/batch_actions
#= require active_admin/base
#= require jquery3
#= require jquery_ujs
#= require popper
#= require bootstrap
#= require_tree ./lib
#= require_self

# $ ->
#   $('[data-toggle="tooltip"]').tooltip()
#   $('#flashes').aaFlash()

onDOMReady = ->
  $('[data-toggle="tooltip"]').tooltip()
  $('#flashes').aaFlash()

$(document)
  .ready(onDOMReady)
  .on('page:load turbolinks:load', onDOMReady);
