module ApplicationHelper
  def price(value, precision = 0)
    number_with_precision(value, precision: precision, delimiter: ' ', separator: '.')
  end
end
