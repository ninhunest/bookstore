class Admin::OrdersController < Admin::AdminController
  before_action :load_order, except: %i(new create index)
  def index
    @orders = Order.attributes_select_order.order_by_created_at
      .page(params[:page]).per Settings.per_page
  end

  def edit
    @order = Order.find_by id: params[:id]
    @line_items = @order.cart.line_items
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t "update_success"
      redirect_to request.referrer
    else
      flash[:danger] = t "update_failed"
      render :edit
    end
  end

  private
  def order_params
    params.require(:order).permit :status
  end
  def load_order
    @order = Order.find_by id: params[:id]

    return if @order
    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
