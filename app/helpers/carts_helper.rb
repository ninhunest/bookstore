module CartsHelper
  def current_cart
    if !session[:cart_id].nil?
      Cart.find_by id: session[:cart_id]
    else
      Cart.new
    end
  end

  def check_item_persent? item
    current_cart.line_items.pluck(:item_id).include? item.id
  end

  def load_items
    line_items = current_cart.line_items
  end

  def total_items
    load_items.sum :quantity
  end

  def total_price
    items = load_items
    @sub_total = Settings.sub_total

    items.each do |item|
      quantity = item.quantity
      book = Book.find_by id: item.item_id

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
