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

  _drop: (event, ui) ->
    target_id = $(event.target).attr('id').split('_').pop()
    item      = ui.draggable
    item_id   = item.attr('id').split('_').pop()
    url       = '/admin/cb_stem_media_items/:id/drop'.replace(':id', item_id)

    $.ajax
      url: url
      type: 'post'
      data:
        parent_id: target_id
      success: (response) ->
        $('body').aaLoading()
      error: (jqXHR) ->
        $('#flash-wrapper').html(jqXHR.responseJSON);
        $('#flashes').aaFlash();
    false

  # Private
  _bind: ->
    options    = @options
    $("##{options.dropAreaId}").aaDropZone()
    $dropzone  = Dropzone.forElement("#" + options.dropAreaId)
    $container = $($dropzone.previewsContainer)
    @$element.on
      'drop': (e) ->
        e.preventDefault()
      'dragover dragenter': (e) ->
        e.preventDefault()
        $(@).addClass options.dropActiveClass
        false
      'dragleave dragexit': (e) ->
        $target = $("##{options.overlayId}")
        return if !($target).is(e.target) && $target.has(e.target).length == 0
        $(@).removeClass options.dropActiveClass

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

    $dropzone.on 'queuecomplete', ->
      if $container.find('.dz-error').length > 0
        $container.addClass options.previewActiveClass
      else
        $container.removeClass options.previewActiveClass

      $('body').data('aaLoading').open()
      $('#main_content_wrapper').load(window.location.href + ' #main_content', ->
        $('body').data('aaLoading').close()
        $('#active_admin_content .dropdown').aaDropdown()
        $('#main_content').aaBatchAction()
      )

$.widget.bridge 'aaMediaLibrary', ActiveAdmin.MediaLibrary
