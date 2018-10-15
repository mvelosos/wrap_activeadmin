class ActiveAdmin.AutoSubmit

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {}

    @options = $.extend defaults, @options
    @_bind()

  _bind: ->
    @$element.change ':input', (e) ->
      e.preventDefault()
      $(@).submit()

$.widget.bridge 'aaAutoSubmit', ActiveAdmin.AutoSubmit
