module WrapActiveadmin

  class DynInputVideoEmbed < DynInput

    validates :value_string,
              presence: true,
              if: proc { field_config['required'] }

    def value
      @value ||= find_value
    end

    private

    def find_value
      return if value_string.blank?
      VideoInfo.new(value_string)
    rescue VideoInfo::UrlError
      nil
    end

  end

end
