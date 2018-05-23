module ViewHelpers

  # ViewHelpers For BlankSlate
  module BlankSlate

    def blank_slate_msg(resource_class:, link: nil)
      config = active_admin_resource_for(resource_class)
      content =
        I18n.t('active_admin.blank_slate.content',
               resource_name: config.plural_resource_label)
      content = safe_join([blank_slate_content, blank_slate_link]).compact if link.present?
      content_tag :div, class: 'blank_slate_container' do
        render('cb_stem/svgs/empty_state.svg') +
          content_tag(:h4, content, class: 'blank_slate display-4')
      end
    end

  end

end
