class ActiveAdmin.CarmenProvinces

  constructor: (@options, @element) ->
    @$element = $(@element)
    @target   = $(@element).data('target')
    @$target  = $(@target)

    defaults = {}

    @options = $.extend defaults, @options

    @_bind()

  _getProvinces: (value)->
    collection = []
    $target    = @$target
    $.get('/admin/carmen_provinces', { country: value }, ((data) ->
      $.each data, (index, value) ->
        collection.push {id: value[1], text: value[0]}
    ), 'json').done(->
      $target.empty()
      if $target.data 'aaSelect2'
        $target.aaSelect2('destroy')
        $target.removeData('aaSelect2')

      $target.aaSelect2(data: collection)
    )

  # Private
  _bind: ->
    @$element.change =>
      @_getProvinces(@$element.val())

$.widget.bridge 'aaCarmenProvinces', ActiveAdmin.CarmenProvinces
