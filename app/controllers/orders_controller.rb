class OrdersController < ApplicationController
  def create
    if Order.create! order_params
      @cart = Cart.new
      session[:cart_id] = @cart.id
      flash[:success] = t "order_successfully"
      redirect_to :root
    else

    end
  end

  private

  def order_params
    params.require(:order).permit :name, :email, :address, :phone, :cart_id
  end
end
