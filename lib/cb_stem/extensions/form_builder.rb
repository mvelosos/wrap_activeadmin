module ActiveAdmin

  # Overwriting FormBuilder - activeadmin/lib/active_admin/form_builder.rb
  class FormBuilder < ::Formtastic::FormBuilder

    CANCEL_CLASS = 'btn btn-light'.freeze

    def cancel_link(url = { action: 'index' }, html_options = {}, li_attrs = {})
      li_attrs[:class]   ||= 'cancel list-inline-item'
      html_options[:class] = CANCEL_CLASS
      li_content = template.link_to I18n.t('active_admin.cancel'), url, html_options
      template.content_tag(:li, li_content, li_attrs)
    end

  end

end
