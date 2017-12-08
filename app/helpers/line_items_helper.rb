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

  def sub_total_price cart
    items = cart.line_items
    @sub_total = Settings.sub_total

    items.each do |item|
      quantity = item.quantity
      book = Book.with_deleted.find_by id: item.item_id

      if book.discount.present?
        price = book.price - book.discount.to_f/Settings.percentage * book.price
      else
        price = book.price
      end

      @sub_total += price * quantity
    end

    @sub_total
  end
end
