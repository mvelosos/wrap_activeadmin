$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link)
  false

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link[0].click()

$.rails.showConfirmDialog = (link) ->
  ActiveAdmin.modal_dialog link.data('confirm'), [],( =>
    $.rails.confirmed(link)
  ), link.data('message')
