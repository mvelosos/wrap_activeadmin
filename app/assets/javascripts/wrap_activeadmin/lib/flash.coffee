class ActiveAdmin.Flash

  constructor: (@options, @element) ->
    @$element = $(@element)

    @$actions = @$element.find('.flash-action')

    defaults = {
      openClass: 'open',
      destroyDelay: 4000,
      autoDestroyDelay: 8000
    }

    @options = $.extend defaults, @options

    @_bind()

  open: ->
    @$element.addClass(@options.openClass)

  destroy: ->
    @$element.removeClass(@options.openClass)
      .delay(@options.destroyDelay).queue (next) =>
        @$element.remove()
        next()
    @

  # Private
  _bind: ->
    @open()

    @$actions.click =>
      @destroy()
      false

    setTimeout (=>
      @destroy()
      false
    ), @options.autoDestroyDelay

$.widget.bridge 'aaFlash', ActiveAdmin.Flash
