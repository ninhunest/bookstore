class Admin::CategoriesController < Admin::AdminController
  before_action :load_category, except: %i(new create index)

  def index
    @categories = Category.category_attributes_select.order_by_created_at
      .page(params[:page]).per Settings.per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params

    if @category.save
      flash[:success] = t "create_category"
      redirect_to request.referrer
    else
      flash[:danger] = t "failed_create"
      redirect_to root_url
    end
  end

  def show
    @books = @category.books.order_by_created_at
      .page(params[:page]).per Settings.per_page
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "update_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "update_failed"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "delete_failed"
    end

    redirect_to request.referrer
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]

    return if @category
    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
