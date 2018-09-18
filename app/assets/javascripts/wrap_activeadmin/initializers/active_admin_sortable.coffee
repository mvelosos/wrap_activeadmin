(($) ->
  $(document).ready ->
    $('.handle').closest('tbody').activeAdminSortable()
    return

  $.fn.activeAdminSortable = ->
    @sortable
      handle: '.handle'
      update: (event, ui) ->
        elem    = ui.item.find('[data-sort-url]')
        url     = elem.data('sort-url')
        fromPos = elem.data('position')
        order   = elem.data('order') or 'asc'
        toPos   = undefined
        # Find the new position of the moved element through the new position of the kicked out element.
        toPos = ui.item.next().find('[data-position]').data('position')
        if toPos == undefined or order == 'asc' and toPos > fromPos or order == 'desc' and toPos < fromPos
          toPos = ui.item.prev().find('[data-position]').data('position')
        $.ajax
          url: url
          type: 'post'
          data:
            position: toPos
          success: (response) ->
            $('#flash-wrapper').html(response);
            $('#flashes').aaFlash();
            return
        return
    @disableSelection()
    return

  return
) jQuery
