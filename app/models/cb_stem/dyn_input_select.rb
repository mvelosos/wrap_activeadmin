module CbStem

  class DynInputSelect < DynInput

    before_validation :format_attrs

    validates :value_array,
              presence: true,
              if: proc { field_config['required'] }

    private

    def format_attrs
      return if value_string.blank?
      self.value_array  = [value_string]
      self.value_string = nil
    end

  end

end
