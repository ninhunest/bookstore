module BooksHelper
  def format_price price
    number_to_currency price, unit: Settings.unit_price, delimiter: ".",
      precision: Settings.books.precision_min, format: "%n %u"
  end

  def get_promotion_price price, discount
    promotion_price = price - discount.to_f/Settings.percentage * price
    format_price promotion_price
  end

  def count_view book
    view = book.view.present? ? book.view : 0
  end

  def is_new_book? created_at
    return created_at > Settings.books.previous_week.weeks.ago
  end

  def show_title_param
    (params[:search].present? && params[:search][:title].present?) ?
      params[:search][:title] : nil
  end

  def show_price_from_param
    (params[:search].present? && params[:search][:price_from].present?) ?
      params[:search][:price_from] : nil
  end

  def show_price_to_param
    (params[:search].present? && params[:search][:price_to].present?) ?
      params[:search][:price_to] : nil
  end
end
