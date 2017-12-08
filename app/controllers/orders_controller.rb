class OrdersController < ApplicationController
  def create
    if Order.create order_params
      send_order_email
      @cart = Cart.new
      session[:cart_id] = @cart.id
      flash[:success] = t "order_successfully"
      redirect_to :root
    else
      flash[:danger] = t "Order failed. Try again!"
      redirect_to :root
    end
  end

  private

  def send_order_email
    custom_email = params[:order][:email]
    custom_name = params[:order][:name]
    custom_cart = params[:order][:cart_id]

    OrderMailer.send_order_info(custom_email, custom_name, custom_cart)
      .deliver_later
  end

  def order_params
    params.require(:order).permit :name, :email, :address, :phone, :cart_id
  end
end
