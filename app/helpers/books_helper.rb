module BooksHelper
  def format_price price
    number_to_currency price, unit: Settings.unit_price, delimiter: ".",
      precision: Settings.books.precision_min, format: "%n %u"
  end

  def get_promotion_price price, discount
    promotion_price = price - discount.to_f/Settings.percentage * price
    format_price promotion_price
  end

  def is_new_book? created_at
    return created_at > Settings.books.previous_week.weeks.ago
  end
end
