class CartsController < ApplicationController
  before_action :load_book, only: %i(create destroy)
  before_action :load_cart, only: %i(create destroy)

  def index
    @line_items = current_cart.line_items
  end

  def create
    @cart.add @book, @book.price
    session[:cart_id] = @cart.id

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @cart.remove @book

    respond_to do |format|
      format.js
    end
  end

  private

  def load_cart
    @cart = current_cart
  end

  def load_book
    @book = Book.find_by id: params[:id]
  end
end
