module WrapActiveadmin

  class DynInputSelect < DynInput

    before_validation :format_attrs

    validates :value_array,
              presence: true,
              if: proc { field_config['required'] }

    def value
      @value ||= find_value
    end

    private

    def find_value
      field_config[:multiple] ? value_array : value_array&.first
    end

    def format_attrs
      return if value_string.blank?
      self.value_array  = [value_string]
      self.value_string = nil
    end

  end

end
