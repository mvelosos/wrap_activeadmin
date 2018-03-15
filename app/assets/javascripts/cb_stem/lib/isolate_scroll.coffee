class ActiveAdmin.IsolateScroll

  constructor: (@options, @element) ->
    @$element = $(@element)
    defaults = {
      offset: 15
    }
    @options = $.extend defaults, @options

    @_bind()

  scroll: (e)->
    e0          = e.originalEvent
    delta       = e0.wheelDelta or -e0.detail
    @$element[0].scrollTop += (if delta < 0 then 1 else -1) * @options.offset
    e.preventDefault()

  # Private
  _bind: ->
    @$element.on 'mousewheel DOMMouseScroll', (e) =>
      @scroll(e)

$.widget.bridge 'aaIsolateScroll', ActiveAdmin.IsolateScroll
