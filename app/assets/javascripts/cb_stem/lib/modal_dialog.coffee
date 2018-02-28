ActiveAdmin.modal_dialog = (message, inputs, callback, title='Are you sure?')->
  html = """<div><div class="body">#{message}</div>"""
  html += """<form id="dialog_confirm" title="#{message}"><ul>"""
  for name, type of inputs
    if /^(datepicker|checkbox|text|number)$/.test type
      wrapper = 'input'
    else if type is 'textarea'
      wrapper = 'textarea'
    else if $.isArray type
      [wrapper, elem, opts, type] = ['select', 'option', type, '']
    else
      throw new Error "Unsupported input type: {#{name}: #{type}}"

    klass = if type is 'datepicker' then type else ''
    html += """<li>
      <label>#{name.charAt(0).toUpperCase() + name.slice(1)}</label>
      <#{wrapper} name="#{name}" class="#{klass}" type="#{type}">""" +
        (if opts then (
          for v in opts
            $elem = $("<#{elem}/>")
            if $.isArray v
              $elem.text(v[0]).val(v[1])
            else
              $elem.text(v)
            $elem.wrap('<div>').parent().html()
        ).join '' else '') +
      "</#{wrapper}>" +
    "</li>"
    [wrapper, elem, opts, type, klass] = [] # unset any temporary variables

  html += "</ul></form></div>"

  form = $(html).appendTo('body')
  $('body').trigger 'modal_dialog:before_open', [form]

  form.dialog
    modal: true
    draggable: false
    title: title
    open: (event, ui) ->
      $('body').trigger 'modal_dialog:after_open', [form]
    dialogClass: 'active_admin_dialog'
    buttons: [
      {
        text: 'Cancel'
        'class': 'btn btn-light'
        click: ->
          $(this).dialog('close').remove()
          return
      }
      {
        text: 'Ok'
        'class': 'btn btn-primary ml-1'
        click: ->
          callback $(this).serializeObject()
          $(this).dialog 'close'
          return
      }
    ]
