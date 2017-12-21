module OrdersHelper
  def load_items_order
    @order = Order.find_by id: params[:id]
    line_items = @order.cart.line_items
  end

  def total_price_order
    @order = Order.find_by id: params[:id]
    line_items = @order.cart.line_items
    items = load_items_order
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

  def count_total_price_order line_item
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
