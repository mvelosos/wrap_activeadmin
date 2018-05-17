class ActiveAdmin.aaDropZone

  constructor: (@options = {}, @element) ->
    @$element = $(@element)

    interacts = {
      dragEnterClass: 'dragenter'
    }

    defaults = {
      autoQueue: true
      thumbnailWidth: 80
      thumbnailHeight: 80
      clickable: false
      dragover: =>
        @$element.addClass @interacts.dragEnterClass
      dragleave: =>
        @$element.removeClass @interacts.dragEnterClass
      drop: =>
        @$element.removeClass @interacts.dragEnterClass
    }

    @interacts = $.extend interacts, @options.interacts
    @options   = $.extend defaults, @options.dropzone

    @_bind()

  _clickable_opt: ->
    clickable = @$element.data('dropzone-clickable')
    @options = $.extend(@options, {
      clickable: clickable
    })

  _preview_opt: ->
    preview = @$element.data('dropzone-preview')
    @options = $.extend(@options, {
      previewsContainer: preview
    })

  _preview_template_opt: ->
    template = @$element.data('dropzone-template')
    html     = $(template).html()
    @options = $.extend(@options, {
      previewTemplate: html
    })

  # Private
  _bind: ->
    if(@$element.data('dropzone-clickable'))
      @_clickable_opt()

    if(@$element.data('dropzone-preview'))
      @_preview_opt()

    if(@$element.data('dropzone-template'))
      @_preview_template_opt()

    new Dropzone @element,
        @options

$.widget.bridge 'aaDropZone', ActiveAdmin.aaDropZone
