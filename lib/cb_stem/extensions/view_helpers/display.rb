module ViewHelpers

  # ViewHelpers For Display
  module Display

    def to_percentage(number, precision: 2)
      number_to_percentage(number, precision: precision)
    end

    def to_currency(number, precision: 2)
      number_to_currency(number, precision: precision)
    end

  end

end
