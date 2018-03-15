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
#= require tinymce
#= require select2-full
#= require_self
#= require active_admin/lib/checkbox-toggler
#= require active_admin/lib/flash
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
  $('#main-menu, #filters_sidebar_section .card-body').aaIsolateScroll()
  $('.form-control-file').aaFileInput()
  $('.tinymce').aaTinyMCE()
  $('.dropdown').aaDropdown()
  $('.select2').aaSelect2()
  $('[data-js="form-trigger"]').aaFormTrigger()
  $('#mobile-menu .dropdown-menu [data-toggle="tooltip"]').tooltip('dispose')

$(document)
  .ready(onDOMReady)
  .on('page:load turbolinks:load', onDOMReady);

$(document)
  .on 'has_many_add:after', '.has_many_container', (e, fieldset, container) ->
    fieldset.find('.select2').aaSelect2()
    fieldset.find('.tinymce').aaTinyMCE()
    fieldset.find('.dropdown').aaDropdown()
    fieldset.find('.form-control-file').aaFileInput()
    fieldset.find('[data-js="form-trigger"]').aaFormTrigger()
    fieldset.find('[data-toggle="tooltip"]').tooltip()
