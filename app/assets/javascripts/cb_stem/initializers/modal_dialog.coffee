$ ->
  $.rails.allowAction = (link) ->
      return true unless link.attr('data-confirm')
      $.rails.showConfirmDialog(link) # look bellow for implementations
      false # always stops the action since code runs asynchronously

  $.rails.confirmed = (link, inputs) ->
    if inputs
      debugger
    else
      link.removeAttr('data-confirm')
      link.trigger('click.rails')

  $.rails.showConfirmDialog = (link) ->
    # ActiveAdmin.modal_dialog  message, [], -> $.rails.confirmed(link)
    title = link.data 'confirm'
    ActiveAdmin.modal_dialog title, link.data('inputs'),( (inputs)=>
      $.rails.confirmed(link, inputs)
    ), link.data('message'), link.data('form')
