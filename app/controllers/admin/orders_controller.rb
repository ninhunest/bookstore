class Admin::OrdersController < Admin::AdminController
  before_action :load_order, except: %i(new create index)

  def index
    @orders = Order.attributes_select_order.order_by_created_at
      .page(params[:page]).per Settings.per_page
  end

  def show

  end

  private
  def load_order
    @order = Order.find_by id: params[:id]

    return if @order
    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
