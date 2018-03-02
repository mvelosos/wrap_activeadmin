#= require jquery3
#= require jquery-ui/widgets/datepicker
#= require jquery-ui/widgets/dialog
#= require jquery-ui/widgets/sortable
#= require jquery-ui/widgets/tabs
#= require jquery-ui/widget
#= require jquery_ujs
#= require popper
#= require bootstrap
#= require bootstrap-datepicker
#= require_self
#= require active_admin/lib/checkbox-toggler
#= require active_admin/lib/flash
#= require active_admin/lib/has_many
#= require active_admin/lib/per_page
#= require active_admin/lib/table-checkbox-toggler
#= require active_admin/ext/jquery-ui
#= require active_admin/ext/jquery
#= require active_admin/initializers/batch_actions
#= require active_admin/initializers/filters
#= require active_admin/initializers/tabs
#= require_tree ./lib
#= require_tree ./initializers

window.ActiveAdmin = {}

onDOMReady = ->
  $('[data-toggle="tooltip"]').tooltip()
  $('#flashes').aaFlash()
  $('#main-menu').aaIsolateScroll()
  $('.form-control-file').aaFileInput()
  $('#mobile-menu .dropdown-menu [data-toggle="tooltip"]').tooltip('dispose')

$(document)
  .ready(onDOMReady)
  .on('page:load turbolinks:load', onDOMReady);
