class ActiveAdmin.BatchAction

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      menuItems: '.batch_actions_selector li a'
    }

    @options = $.extend defaults, @options

    @_bind()

  _batchActionLink: ->
    @$element.find(@options.menuItems).on 'click', (e) ->
      e.stopPropagation() # prevent Rails UJS click event
      e.preventDefault()
      if title = $(@).data 'confirm'
        ActiveAdmin.modal_dialog title, $(@).data('inputs'),( (inputs) =>
          $(@).trigger 'confirm:complete', inputs
        ), $(@).data('message'), $(@).data('form')
      else
        $(@).trigger 'confirm:complete'

  _actionConfirmed: ->
    @$element.find(@options.menuItems).on 'confirm:complete', (e, inputs) ->
      if val = JSON.stringify inputs
        $('#batch_action_inputs').removeAttr('disabled').val val
      else
        $('#batch_action_inputs').attr 'disabled', 'disabled'

      $('#batch_action').val $(@).data 'action'
      $('#collection_selection').submit()

  # Private
  _bind: ->
    @_batchActionLink()
    @_actionConfirmed()

    $indexTable    = @$element.find('.paginated_collection table.index_table')
    $batchSelector = @$element.find('.batch_actions_selector')

    return unless $batchSelector.length && @$element.find(':checkbox.toggle_all').length

    if $indexTable.length
      $indexTable.tableCheckboxToggler()
    else
      @$element.find('.paginated_collection').checkboxToggler()

    @$element.on 'change', '.paginated_collection :checkbox', =>
      if @$element.find('.paginated_collection :checkbox:checked').length
        $batchSelector.each -> $(@).find('.dropdown-toggle').removeClass('disabled')
      else
        $batchSelector.each -> $(@).find('.dropdown-toggle').addClass('disabled')

$.widget.bridge 'aaBatchAction', ActiveAdmin.BatchAction
