class ActiveAdmin.FormTrigger

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {}

    @options = $.extend defaults, @options

    @_bind()

  # Private
  _bind: ->
    @$element.on 'click', (e)->
      e.preventDefault()
      target = $(@).data('target')
      $(target).submit()
      false

$.widget.bridge 'aaFormTrigger', ActiveAdmin.FormTrigger
