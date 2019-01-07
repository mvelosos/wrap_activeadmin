module ViewHelpers

  # ViewHelpers For Country
  module Country

    def country_options(*args)
      opts      = args.extract_options!
      countries = opts.delete(:countries) { Carmen::Country.all }
      countries.map { |x| country_option(x, *args) }
    end

    def province_options(country)
      return [] if country.blank? || Carmen::Country.coded(country).blank?
      Carmen::Country.coded(country).subregions.map { |u| [u.name, u.name] }
    end

    def currency_options
      @currency_options ||=
        ISO3166::Country.all.map(&:currency_code).uniq.sort
    end

    def country_identifier(country)
      return if country&.code.blank?
      content_tag :div, class: 'table-item-identifier' do
        concat(flag_icon(country.code.downcase, class: 'mr-3'))
        concat(content_tag(:span, country.name, class: 'identifier-text'))
      end
    end

    private

    def country_option(country, *args)
      opts = args.extract_options!
      key  = opts.delete(:key) { :code }
      if country.is_a? String
        name = I18n.t(country, scope: %i[active_admin countries])
        [name, country, { 'data-template': string_opt(name) }]
      else
        [country.name, country.try(key), { 'data-template': country_identifier(country) }]
      end
    end

    def string_opt(name)
      content_tag :div, class: 'table-item-identifier' do
        content_tag(:span, name, class: 'identifier-text')
      end
    end

  end

end
