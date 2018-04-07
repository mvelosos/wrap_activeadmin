# Extend ActiveAdmin ViewHelpers
module ActiveAdmin::ViewHelpers

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

  def menu_label(label, icon: nil, badge: 0)
    safe_join [
      aa_icon(icon),
      menu_title(label),
      menu_badge(badge)
    ]
  end

  def to_percentage(number, precision: 2)
    number_to_percentage(number, precision: precision)
  end

  def to_currency(number, precision: 2)
    number_to_currency(number, precision: precision)
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

  def currency_identifier(country, currency)
    return if country&.code.blank?
    content_tag :div, class: 'table-item-identifier' do
      concat(flag_icon(country.code.downcase, class: 'mr-3'))
      concat(content_tag(:span, "#{country.name} - #{currency}", class: 'identifier-text'))
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

  # rubocop:disable Metrics/MethodLength
  def thumbnail(object, image, *args)
    return unless image
    options = args.extract_options!
    klass   = options.delete(:class)
    icon    = options.delete(:icon) { 'image-2' }
    size    = options.delete(:size) { nil }
    url_method = options.delete(:url_method) { '_url' }
    content_tag :div, class: "thumbnail #{klass}" do
      if object.try(image).present? && object.try("#{image}#{url_method}", size)
        image_tag(object.send("#{image}#{url_method}", size), *args)
      else
        aa_icon(icon)
      end
    end
  end

  def color_brick(color, *args)
    options = args.extract_options!
    klass   = options.delete(:class)
    options[:class] = "color-brick #{klass}".strip
    content_tag :div, '', options.merge(style: "background-color: #{color};")
  end

  alias batch_form active_admin_form_for

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
    content_tag(:span, badge, class: 'badge badge-pill badge-primary')
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
