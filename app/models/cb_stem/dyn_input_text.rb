module CbStem

  class DynInputText < DynInput

    validates :value_text,
              presence: true,
              if: proc { field_config['required'] }

  end

end
