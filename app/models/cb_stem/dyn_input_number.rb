module CbStem

  class DynInputNumber < DynInput

    validates :value_number,
              presence: true,
              if: proc { field_config['required'] }

  end

end
