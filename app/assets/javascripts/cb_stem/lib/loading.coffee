class ActiveAdmin.Loading

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      openClass: 'window-loading'
    }

    @options = $.extend defaults, @options

    @_bind()

  open: ->
    @$element.addClass(@options.openClass)

  close: ->
    @$element.removeClass(@options.openClass)

  # Private
  _bind: ->
    @

$.widget.bridge 'aaLoading', ActiveAdmin.Loading
