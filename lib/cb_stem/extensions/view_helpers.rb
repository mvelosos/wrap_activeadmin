# Extend ActiveAdmin ViewHelpers
# rubocop:disable Metrics/ModuleLength
module ActiveAdmin::ViewHelpers

  alias batch_form active_admin_form_for

  def select_tab?(target_tab, key: :tab)
    return unless target_tab == params[key]
    'selected'
  end

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

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def action_btn(title, url, html_options = {})
    icon          = html_options.delete(:icon)  { nil }
    display_title = html_options.delete(:title) { false }
    data          = html_options.delete(:data)  { {} }
    html_options[:class] ||= 'btn-link'
    html_options[:class]   = "btn #{html_options[:class]}".strip.squeeze
    options =
      html_options.merge(
        title: title,
        data: { toggle: 'tooltip', placement: 'bottom' }.merge(data)
      )
    link_to url, options do
      concat content_tag(:i, '', class: "nc-icon nc-#{icon}") if icon
      concat content_tag(:span, title, class: 'action-text')  if display_title
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

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
  # rubocop:enable Metrics/MethodLength

  def color_brick(color, *args)
    options = args.extract_options!
    klass   = options.delete(:class)
    options[:class] = "color-brick #{klass}".strip
    content_tag :div, '', options.merge(style: "background-color: #{color};")
  end

  def aa_icon(icon)
    return if icon.blank?
    content_tag(:i, '', class: "nc-icon nc-#{icon}")
  end

  private

  def menu_title(label)
    title = label.is_a?(Class) ? label.model_name.human(count: 2) : label
    content_tag(:span, title, class: 'menu-text')
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
