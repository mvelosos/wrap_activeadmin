# MediaHelpers
module CbStem::MediaHelpers

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

end
