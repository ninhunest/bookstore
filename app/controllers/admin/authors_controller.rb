class Admin::AuthorsController < Admin::AdminController
  before_action :load_author, except: %i(new create index)

  def index
    @authors = Author.author_attributes_select.order_by_created_at
      .page(params[:page]).per Settings.per_page
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params

    if @author.save
      flash[:success] = t "created_author"
      redirect_to request.referrer
    else
      flash[:danger] = t "failed_create"
      redirect_to root_url
    end
  end

  def show
    @books = @author.books.page(params[:page]).per Settings.per_page
  end

  def edit; end

  def update
    if @author.update_attributes author_params
      flash[:success] = t "update_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "update_failed"
      render :edit
    end
  end

  def destroy
    if @author.destroy
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "delete_failed"
    end

    redirect_to request.referrer
  end

  private

  def author_params
    params.require(:author).permit :name, :email
  end

  def load_author
    @author = Author.find_by id: params[:id]

    return if @author
    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
