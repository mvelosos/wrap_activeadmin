module WrapActiveadmin

  class DynInputRelation < DynInput

    before_validation :format_attrs

    validates :value_array,
              presence: true,
              if: proc { field_config['required'] }

    def value
      @value ||= find_value
    end

    private

    def find_value
      model_type = field_config['relation_type']
      return unless Object.const_defined?(model_type)
      records = model_type.constantize.where(id: value_array)
      field_config[:multiple] ? records : records&.first
    end

    def format_attrs
      return if value_string.blank?
      self.value_array  = [value_string]
      self.value_string = nil
    end

  end

end
