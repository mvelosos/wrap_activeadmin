onDOMReady = ->
  #
  # Use ActiveAdmin.modal_dialog to prompt user if confirmation is required for current Batch Action
  #
  $('.batch_actions_selector li a').click (e)->
    e.stopPropagation() # prevent Rails UJS click event
    e.preventDefault()
    if title = $(@).data 'confirm'
      ActiveAdmin.modal_dialog title, $(@).data('inputs'),( (inputs)=>
        $(@).trigger 'confirm:complete', inputs
      ), $(@).data('message'), $(@).data('form')
    else
      $(@).trigger 'confirm:complete'

  $('.batch_actions_selector li a').on 'confirm:complete', (e, inputs)->
    if val = JSON.stringify inputs
      $('#batch_action_inputs').removeAttr('disabled').val val
    else
      $('#batch_action_inputs').attr 'disabled', 'disabled'

    $('#batch_action').val $(@).data 'action'
    $('#collection_selection').submit()

  #
  # Add checkbox selection to resource tables and lists if batch actions are enabled
  #

  if $(".batch_actions_selector").length && $(":checkbox.toggle_all").length

    if $(".paginated_collection table.index_table").length
      $(".paginated_collection table.index_table").tableCheckboxToggler()
    else
      $(".paginated_collection").checkboxToggler()

    $(document).on 'change', '.paginated_collection :checkbox', ->
      if $(".paginated_collection :checkbox:checked").length
        $(".batch_actions_selector").each -> $(@).find('.dropdown-toggle').removeClass('disabled')
      else
        $(".batch_actions_selector").each -> $(@).find('.dropdown-toggle').addClass('disabled')

$(document).
  ready(onDOMReady).
  on 'page:load turbolinks:load', onDOMReady
