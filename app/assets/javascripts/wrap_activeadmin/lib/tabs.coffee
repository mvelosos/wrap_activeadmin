class ActiveAdmin.Tabs

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      excludeClass: 'disable-jquery-ui-tabs'
    }

    @options = $.extend defaults, @options

    @_bind()

  # Private
  _bind: ->
    return if @$element.hasClass @options.excludeClass
    @$element.tabs()

$.widget.bridge 'aaTabs', ActiveAdmin.Tabs
