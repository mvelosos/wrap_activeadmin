# Extend ActiveAdmin ViewHelpers
module ActiveAdmin::ViewHelpers

  def flash_messages
    flash.each do |type, msg|
      concat(content_tag(:div, msg, class: "alert #{bs_class_for(type)}"))
    end
    nil
  end

  def devise_error_messages!
    return '' unless devise_error_messages?
    devise_error_html&.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

  private

  def devise_error_html
    messages = resource.errors.full_messages.join(', ')
    <<-HTML
    <div class='alert alert-danger'>
      #{messages}
    </div>
    HTML
  end

  def bs_class_for(type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }[type.to_sym] || type.to_s
  end

end
