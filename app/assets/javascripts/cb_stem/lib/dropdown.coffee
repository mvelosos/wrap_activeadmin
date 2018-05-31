class ActiveAdmin.Dropdown

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      toggle: '.dropdown-toggle'
      menu: '.dropdown-menu'
    }

    @options = $.extend defaults, @options

    @_bind()

  # Private
  _bind: ->
    options = @options
    @$element.on 'show.bs.dropdown', ->
      $btnDropDown = $(@).find(options.toggle)
      $listHolder = $(@).find(options.menu)
      #reset position property for DD container
      $(@).css 'position', 'static'
      $listHolder.css
        'top': $btnDropDown.offset().top + $btnDropDown.outerHeight(true) + 'px'
        'left': $btnDropDown.offset().left + 'px'
      $listHolder.data 'open', true
      return
    #add BT DD hide event
    @$element.on 'hidden.bs.dropdown', ->
      $listHolder = $(@).find(options.menu)
      $listHolder.data 'open', false
      return

$.widget.bridge 'aaDropdown', ActiveAdmin.Dropdown
