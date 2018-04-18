$ ->
  $.rails.allowAction = (link) ->
      return true unless link.attr('data-confirm')
      $.rails.showConfirmDialog(link) # look bellow for implementations
      false # always stops the action since code runs asynchronously

  $.rails.confirmed = (link, inputs) ->
    link.removeAttr('data-confirm')
    link.trigger('click.rails')

  $.rails.showConfirmDialog = (link) ->
    ActiveAdmin.modal_dialog  link.data('confirm'), [],( ->
      $.rails.confirmed(link)
    ), link.data('message')
