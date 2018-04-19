class ActiveAdmin.Loading

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      delay: 3000
      openClass: 'window-loading'
    }

    @options = $.extend defaults, @options

    @_bind()

  open: ->
    @$element.addClass(@options.openClass)

  # Private
  _bind: ->
    @open()

    setTimeout (=>
      window.location.reload()
      false
    ), @options.delay

$.widget.bridge 'aaLoading', ActiveAdmin.Loading
