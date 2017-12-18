class LineItemsController < ApplicationController
  before_action :load_book, only: %i(create remove_from_index)
  before_action :load_cart, only: %i(create destroy remove_from_index)
  before_action :load_item, only: :destroy

  def create
    @cart.save!
    @cart.add @book, @book.price
    session[:cart_id] = @cart.id

    respond_to do |format|
      format.js
    end
  end

  def remove_from_index
    @line_item = LineItem.line_items current_cart, @book
    quantity = @line_item.pluck(:quantity).first

    if @cart.remove @book, quantity
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "delete_items_failed"
      redirect_to @book
    end
  end

  def destroy
    book = @line_item.book
    quantity = @line_item.quantity

    if @cart.remove book, quantity
      @line_items = @cart.line_items

      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "delete_items_failed"
      redirect_to @book
    end
  end

  private

  def load_cart
    @cart = current_cart
  end

  def load_item
    @line_item = LineItem.find_by id: params[:id]
  end

  def load_book
    @book = Book.find_by id: params[:id]

    return if @book
    flash[:danger] = t "book_not_found"
    redirect_to :root
  end
end
