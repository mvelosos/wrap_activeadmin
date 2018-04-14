# FormatHelpers
module CbStem::FormatHelpers

  def to_percentage(number, precision: 2)
    number_to_percentage(number, precision: precision)
  end

  def to_currency(number, precision: 2)
    number_to_currency(number, precision: precision)
  end

end
