class ActiveAdmin.MediaLibrary

  constructor: (@options = {}, @element) ->
    @$element = $(@element)

    options = {
      uploadPopupId:      'media-upload-popup'
      overlayId:          'media-items-upload'
      dropActiveClass:    'media-droppable'
      dropAreaId:         'drop-holder'
      previewActiveClass: 'active'
    }

    @options = $.extend options, @options
    @_bind()

  _dropHolderInit: ->
    options = @options
    $target = $("##{options.overlayId}")
    @$element.on
      'drop': (e) ->
        e.preventDefault()
      'dragover dragenter': (e) ->
        e.preventDefault()
        $(@).addClass options.dropActiveClass
        false
      'dragleave dragexit': (e) ->
        return if !($target).is(e.target) && $target.has(e.target).length == 0
        $(@).removeClass options.dropActiveClass
    return

  _refreshPage: ->
    $('body').data('aaLoading').open()
    $('#main_content_wrapper').load(window.location.href + ' #main_content', ->
      $('body').data('aaLoading').close()
      $('#active_admin_content .dropdown').aaDropdown()
      $('#main_content').aaBatchAction()
    )
    return

  _collectionUpload: ->
    return unless @$element.hasClass 'index'
    options    = @options
    $("##{options.dropAreaId}").aaDropZone()
    $dropzone  = Dropzone.forElement("#" + options.dropAreaId)
    $container = $($dropzone.previewsContainer)
    @_dropHolderInit()

    @$element.on 'click', '#clear-queue', (e) ->
      e.preventDefault()
      $container.parent("##{options.uploadPopupId}").
        removeClass options.previewActiveClass
      $container.empty()
      false

    $dropzone.on 'drop', =>
      @$element.removeClass options.dropActiveClass

    $dropzone.on 'addedfile', (file) ->
      $container.parent("##{options.uploadPopupId}").
        addClass options.previewActiveClass

    $dropzone.on 'queuecomplete', =>
      if $container.find('.dz-error').length > 0
        $container.addClass options.previewActiveClass
      else
        $container.removeClass options.previewActiveClass
      @_refreshPage()

  _memberUpload: ->
    return unless @$element.hasClass 'show'
    options = @options
    $("##{options.dropAreaId}").aaDropZone()
    $dropzone = Dropzone.forElement("#" + options.dropAreaId)
    @_dropHolderInit(previewTemplate: false)

    $dropzone.on 'drop', =>
      @$element.removeClass options.dropActiveClass

    $dropzone.on 'error', (_file, errorMessage, _xhrObj)->
      $('#flash-wrapper').html(errorMessage)
      $('#flashes').aaFlash()

    $dropzone.on 'queuecomplete', =>
      @_refreshPage()

  # Private
  _bind: ->
    @_collectionUpload()
    @_memberUpload()

$.widget.bridge 'aaMediaLibrary', ActiveAdmin.MediaLibrary
