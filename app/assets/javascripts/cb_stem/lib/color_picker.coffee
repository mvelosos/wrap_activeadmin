class ActiveAdmin.ColorPicker

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      'theme': 'bootstrap'
      'letterCase': 'uppercase'
    }

    @options = $.extend defaults, @options
    @_bind()

  destroy: ->
    @$element.minicolors('destroy')

  _bind: ->
    @$element.minicolors(@options)
    @

$.widget.bridge 'aaColorPicker', ActiveAdmin.ColorPicker
