module ViewHelpers

  # ViewHelpers For Component
  module Component

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def action_btn(title, url, html_options = {})
      icon          = html_options.delete(:icon)  { nil }
      display_title = html_options.delete(:title) { false }
      data          = html_options.delete(:data)  { {} }
      html_options[:class] ||= 'btn-link'
      html_options[:class]   = "btn #{html_options[:class]}".strip.squeeze
      options                = html_options.merge(title: title, data: data)
      link_to url, options do
        concat content_tag(:span, '', class: 'tooltip-holder',
                                      title: title,
                                      data: { toggle: 'tooltip', placement: 'bottom' })
        concat content_tag(:i, '', class: "aa-icon aa-#{icon}") if icon
        concat content_tag(:span, title, class: 'action-text')  if display_title
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    def modal(*args, &block)
      # @TODO: need to move to Arbre Component
      html_options = args.extract_options!
      size         = html_options.delete(:size) { nil }
      wrapper_klass = %w[modal-dialog]
      wrapper_klass.push size if size.present?
      options =
        { class: 'modal fade', data: { backdrop: 'static' } }.
        merge(html_options)
      content_tag :div, options do
        content_tag :div, class: wrapper_klass do
          content_tag :div, class: 'modal-content' do
            instance_exec(&block) if block_given?
          end
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

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
      icon    = options.delete(:icon) { 'image' }
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
      content_tag :div, '', options.merge(style: "background: #{color};")
    end

  end

end
