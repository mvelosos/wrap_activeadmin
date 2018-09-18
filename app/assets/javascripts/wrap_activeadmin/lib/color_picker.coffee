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

  _swatch_opts: (swatches)->
    @options = $.extend(@options, {
      'swatches': swatches
    })

  _bind: ->
    swatches = @$element.data('minicolors-swatch')
    if swatches && $.isArray(swatches)
      @_swatch_opts(swatches)

    @$element.minicolors(@options)
    @

$.widget.bridge 'aaColorPicker', ActiveAdmin.ColorPicker
