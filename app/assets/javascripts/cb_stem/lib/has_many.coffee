$ ->
  $(document).on 'click', 'a.button.has_many_remove', (e)->
    e.preventDefault()
    parent    = $(@).closest '.has_many_container'
    to_remove = $(@).closest 'fieldset'
    recompute_positions parent

    parent.trigger 'has_many_remove:before', [to_remove, parent]
    to_remove.remove()
    parent.trigger 'has_many_remove:after', [to_remove, parent]

  $(document).on 'click', 'a.button.has_many_add', (e)->
    e.preventDefault()
    parent = $(@).closest '.has_many_container'
    parent.trigger before_add = $.Event('has_many_add:before'), [parent]

    unless before_add.isDefaultPrevented()
      index = parent.data('has_many_index') || parent.children('fieldset').length - 1
      parent.data has_many_index: ++index

      regex = new RegExp $(@).data('placeholder'), 'g'
      html  = $(@).data('html').replace regex, index

      fieldset = $(html).insertBefore(@)
      recompute_positions parent
      parent.trigger 'has_many_add:after', [fieldset, parent]

  $(document).on 'change','.has_many_container[data-sortable] :input[name$="[_destroy]"]', ->
    recompute_positions $(@).closest '.has_many'

  init_sortable()
  $(document).on 'has_many_add:after', '.has_many_container', init_sortable

init_sortable = ->
  elems = $('.has_many_container[data-sortable]:not(.ui-sortable)')
  elems.sortable \
    items: '> .has_many_fields',
    handle: '.has-many-handle',
    stop:    recompute_positions
  elems.each recompute_positions

recompute_positions = (parent)->
  parent     = if parent instanceof jQuery then parent else $(@)
  input_name = parent.data 'sortable'
  position   = parseInt(parent.data('sortable-start') || 0, 10)

  parent.children('fieldset').each ->
    # We ignore nested inputs, so when defining your has_many, be sure to keep
    # your sortable input at the root of the has_many block.
    destroy_input  = $(@).find ":input[name$='[_destroy]']"
    sortable_input = $(@).find ":input[name$='[#{input_name}]']"

    if sortable_input.length
      sortable_input.val if destroy_input.is ':checked' then '' else position++
