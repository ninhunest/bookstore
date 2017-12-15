module LineItemsHelper
  def count_total_price line_item
    book_price = line_item.book.price
    quantity = line_item.quantity

    if line_item.book.discount.present?
      book_discount = line_item.book.discount
      total = (book_price - book_price * book_discount/Settings.percentage) * quantity
    else
      total = book_price * quantity
    end

    total
  end
end
