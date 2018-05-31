module ViewHelpers

  # ViewHelpers For Display
  module Display

    def to_percentage(number, precision: 2)
      number_to_percentage(number, precision: precision)
    end

    def to_currency(number, precision: 2)
      number_to_currency(number, precision: precision)
    end

    def seconds_to_time(seconds)
      [seconds / 3600, seconds / 60 % 60, seconds % 60].
        map { |t| t.to_s.rjust(2, '0') }.join(':')
    end

  end

end
