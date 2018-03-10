# Extend ActiveAdmin ViewHelpers
module ActiveAdmin::ViewHelpers

  def menu_label(label, icon: nil, badge: 0)
    safe_join [
      aa_icon(icon),
      menu_title(label),
      menu_badge(badge)
    ]
  end

  def table_item_identifier(title, url, object, image: nil, options: {})
    link_to url, class: 'table-item-identifier' do
      concat(thumbnail(object, image, options)) if image
      concat(content_tag(:span, title, class: 'identifier-text'))
    end
  end

  def item_identifier(title, object, image: nil, options: {})
    content_tag :div, class: 'table-item-identifier' do
      concat(thumbnail(object, image, options)) if image
      concat(content_tag(:span, title, class: 'identifier-text'))
    end
  end

  def country_identifier(country)
    return if country&.code.blank?
    content_tag :div, class: 'table-item-identifier' do
      concat(flag_icon(country.code.downcase, class: 'mr-3'))
      concat(content_tag(:span, country.name, class: 'identifier-text'))
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
    devise_error_html&.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

  def thumbnail(object, image, *args)
    return unless image
    options = args.extract_options!
    klass   = options.delete(:class)
    icon    = options.delete(:icon) { 'image-2' }
    content_tag :div, class: "thumbnail #{klass}" do
      object.try(image).present? ? image_tag(object.send(image), *args) : aa_icon(icon)
    end
  end

  def color_brick(color, *args)
    options = args.extract_options!
    klass   = options.delete(:class)
    options[:class] = "color-brick #{klass}".strip
    content_tag :div, '', options.merge(style: "background-color: #{color};")
  end

  private

  def aa_icon(icon)
    return if icon.blank?
    content_tag(:i, '', class: "nc-icon nc-#{icon}")
  end

  def menu_title(label)
    content_tag(:span, label, class: 'menu-text')
  end

  def menu_badge(badge)
    return unless badge.is_a?(Integer) && badge.positive?
    badge = '99+' if badge > 99
    content_tag(:span, badge, class: 'badge badge-pill badge-success')
  end

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
