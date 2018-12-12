module ViewHelpers

  # ViewHelpers For Notice
  module Notice

    def error_messages(resource)
      return if resource.errors.blank?
      content_tag :div, class: 'alert alert-danger' do
        content_tag :ul, class: 'errors mb-0 pl-3' do
          resource.errors.details.keys.each do |x|
            concat content_tag(:li, resource.errors.full_messages_for(x).first)
          end
        end
      end
    end

    def flashes_html
      flash.each do |type, msg|
        concat(content_tag(:div, msg, class: "alert #{bs_class_for(type)}"))
      end
      nil
    end

    def devise_error_messages!
      return '' unless devise_error_messages?
      safe_join [devise_error_html]
    end

    def devise_error_messages?
      !resource.errors.empty?
    end

    private

    def devise_error_html
      messages = resource.errors.full_messages.join(', ')
      content_tag :div, messages, class: 'alert alert-danger'
    end

  end

end
