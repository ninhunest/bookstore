class Admin::PublishersController < Admin::AdminController
  before_action :load_publisher, except: %i(new create index)

  def index
    @publishers = Publisher.attributes_select_publisher.order_by_created_at
      .page(params[:page]).per Settings.per_page
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publisher_params

    if @publisher.save
      flash[:success] = t "create_publisher"
      redirect_to request.referrer
    else
      flash[:danger] = t "failed_create"
      redirect_to root_url
    end
  end

  def show
    @books = @publisher.books.order_by_created_at
      .page(params[:page]).per Settings.per_page
  end

  def edit; end

  def update
    if @publisher.update_attributes publisher_params
      flash[:success] = t "update_success"
      redirect_to admin_publishers_path
    else
      flash[:danger] = t "update_failed"
      render :edit
    end
  end

  def destroy
    if @publisher.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "delete_failed"
    end

    redirect_to request.referrer
  end

  private

  def publisher_params
    params.require(:publisher).permit :name, :address, :email, :phone
  end

  def load_publisher
    @publisher = Publisher.find_by id: params[:id]

    return if @publisher
    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
