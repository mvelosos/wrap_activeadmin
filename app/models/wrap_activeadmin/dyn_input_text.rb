module WrapActiveadmin

  class DynInputText < DynInput

    validates :value_text,
              presence: true,
              if: proc { field_config['required'] }

    alias_attribute :value, :value_text

  end

end
