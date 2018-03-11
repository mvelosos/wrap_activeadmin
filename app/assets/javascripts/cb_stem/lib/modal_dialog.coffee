ActiveAdmin.modal_dialog = (title, inputs, callback, message='', form='')->
  html = "<div class='body'>"
  if message
    html += """<p>#{message}</p>"""
  if form
    html += """<div>#{form}</div>"""
  if inputs
    html += """<form id="dialog_confirm" title="#{title}"><ul>"""
    for name, type of inputs
      if /^(datepicker|checkbox|text|number)$/.test type
        wrapper = 'input'
      else if type is 'textarea'
        wrapper = 'textarea'
      else if $.isArray type
        [wrapper, elem, opts, type] = ['select', 'option', type, '']
      else
        throw new Error "Unsupported input type: {#{name}: #{type}}"

      klass =
        if type is 'datepicker'
          type
        else if wrapper is 'select'
          'select2'
        else
          ''

      html += """<li class='form-group'>
        <label>#{name.charAt(0).toUpperCase() + name.slice(1)}</label>
        <#{wrapper} name="#{name}" class="#{klass} form-control" type="#{type}">""" +
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
    html += "</ul></form>"

  html += "</div>"

  form = $(html).appendTo('body')
  $('body').trigger 'modal_dialog:before_open', [form]

  form.dialog
    modal: true
    draggable: false
    title: title
    open: (event, ui) ->
      $('body').trigger 'modal_dialog:after_open', [form]
      $('form .select2').aaSelect2()
      $('body').addClass 'modal-open'
    close: (event, ui) ->
      $('body').removeClass 'modal-open'
    dialogClass: 'active_admin_dialog'
    buttons: [
      {
        text: 'Cancel'
        'class': 'btn btn-light'
        click: ->
          $(this).dialog('close').remove()
      }
      {
        text: 'Ok'
        'class': 'btn btn-primary ml-1'
        click: ->
          callback $(@).find('form').serializeObject()
          $(@).dialog 'close'
      }
    ]
