# IdentifierHelpers
module CbStem::IdentifierHelpers

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

end
