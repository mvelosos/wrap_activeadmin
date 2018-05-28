module CbStem

  class DynInputString < DynInput

    validates :value_string,
              presence: true,
              if: proc { field_config['required'] }

  end

end
