module WrapActiveadmin

  class DynInputNumber < DynInput

    validates :value_number,
              presence: true,
              if: proc { field_config['required'] }

    alias_attribute :value, :value_number

  end

end
