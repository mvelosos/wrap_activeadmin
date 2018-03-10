class ActiveAdmin.TinyMCE

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      themes: 'modern'
      height: 250
      menubar: false
      plugins: [
        'autolink lists link charmap print preview anchor',
        'insertdatetime media table contextmenu',
        'table textcolor wordcount hr'
      ]
      toolbar1: 'undo redo | formatselect | bold italic underline strikethrough superscript subscript | alignleft aligncenter alignright | bullist numlist | link hr table'
      block_formats: 'Heading 1=h1;Heading 2=h2;Heading 3=h3;Heading 4=h4;Heading 5=h5;Heading 6=h6;Paragraph=p'
      preview_styles: true
      style_formats: false
      browser_spellcheck: true
      elementpath: false
      branding: false
      table_appearance_options: false
      table_advtab: false
      table_cell_advtab: false
      table_row_advtab: false
      code_dialog_height: 300
      code_dialog_width: 300
    }

    @options = $.extend defaults, @options

    @_bind()

  create: ->
    @options = $.extend @options, { target: @element, height: @$element.height() }
    tinyMCE.init(@options)
    @

  # Private
  _bind: ()->
    @create()

$.widget.bridge 'aaTinyMCE', ActiveAdmin.TinyMCE
