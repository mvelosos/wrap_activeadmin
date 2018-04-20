class ActiveAdmin.MediaLibrary

  constructor: (@options = {}, @element) ->
    @$element = $(@element)

    draggable = {
      revert: 'invalid'
      helper: 'clone'
      handle: '.handle'
      start: (event, ui) ->
        $(event.target).addClass 'dragging'
      stop: (event, ui) ->
        $(event.target).removeClass 'dragging'
    }

    droppable = {
      accept: '.index_table tbody tr'
      over: (event, ui) ->
        ui.draggable.addClass 'dropping'
      out: (event, ui) ->
        ui.draggable.removeClass 'dropping'
      drop: (event, ui) =>
        event.preventDefault()
        @_drop(event, ui)
        false
    }

    @droppable = $.extend droppable, @options.droppable
    @draggable = $.extend draggable, @options.draggable

    @_bind()

  _drop: (event, ui) ->
    target_id = $(event.target).attr('id').split('_').pop()
    item      = ui.draggable
    item_id   = item.attr('id').split('_').pop()
    url       = '/admin/cb_stem_media_items/:id/drop'.replace(':id', item_id)

    $.ajax
      url: url
      type: 'post'
      data:
        parent_id: target_id
      success: (response) ->
        $('body').aaLoading()
      error: (jqXHR) ->
        $('#flash-wrapper').html(jqXHR.responseJSON);
        $('#flashes').aaFlash();
    false

  # Private
  _bind: ->
    droppable_opts = @droppable
    @$element.find(droppable_opts.accept).draggable @draggable
    @$element.find(droppable_opts.accept).each ->
      $(@).droppable droppable_opts

$.widget.bridge 'aaMediaLibrary', ActiveAdmin.MediaLibrary
