class ActiveAdmin.FileInput

  constructor: (@options, @element) ->
    @$element = $(@element)
    @$input   = @$element.find('input')
    @$text    = @$element.find('.file-text')

    defaults  = {
      activeClass: 'active'
    }

    @options = $.extend defaults, @options

    @_bind()

  readUrl: (input)->
    return unless input.files[0].type.includes('image')
    reader = new FileReader
    target = @$element.find('.file-preview')

    reader.onload = (e) ->
      image =  "<img src='#{e.target.result}'/>"
      target.html image

    reader.readAsDataURL input.files[0]
    @

  update: (e)->
    input = e.target
    if input.files and input.files[0]
      @$text.text input.files[0].name
      @$element.addClass @options.activeClass
      @readUrl(e.target)
    else
      @$element.removeClass @options.activeClass

  # Private
  _bind: ->
    @$input.on 'change', (e)=>
      @update(e)
      false

$.widget.bridge 'aaFileInput', ActiveAdmin.FileInput
