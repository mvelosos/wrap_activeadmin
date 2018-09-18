module ViewHelpers

  # ViewHelpers For BlankSlate
  module BlankSlate

    def blank_slate_msg(resource_class:, link: nil, icon: true)
      content =
        I18n.t('active_admin.blank_slate.content',
               resource_name: resource_class.model_name.human(count: 2))
      content = safe_join([blank_slate_content, blank_slate_link]).compact if link.present?
      content_tag :div, class: 'blank_slate_container' do
        html = []
        html << render('wrap_activeadmin/svgs/empty_state.svg') if icon
        html << content_tag(:h4, content, class: 'blank_slate display-4')
        safe_join html
      end
    end

  end

end
