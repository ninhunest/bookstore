class Admin::BooksController < Admin::AdminController
  before_action :load_categories, :load_authors, :load_publishers,
    only: %i(new edit)
  before_action :load_book, only: %i(edit update destroy)

  def index
    @books = Book.attributes_select.order_by_created_at
      .page(params[:page]).per Settings.per_page
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params

    if @book.save
      flash[:success] = t "create_book"
      redirect_to request.referrer
    else
      flash[:danger] = t "failed_create"
      redirect_to root_url
    end
  end

  def edit; end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "update_success"
      redirect_to admin_books_path
    else
      flash[:danger] = t "update_failed"
      render :edit
    end
  end

  def destroy
    if @book.delete
      flash[:success] = t "deleted"
    else
      flash[:danger] = t "delete_failed"
    end

    redirect_to request.referrer
  end

  private

  def book_params
    params.require(:book).permit :title, :category_id, :image_url,
      :publisher_id, :description, :price, :discount, author_ids: []
  end

  def load_book
    @book = Book.find_by id: params[:id]

    return if @book
    flash[:danger] = t "book_not_found"
    redirect_to root_path
  end

  def load_categories
    @categories = Category.all
  end

  def load_authors
    @authors = Author.all
  end

  def load_publishers
    @publishers = Publisher.attributes_select_publisher
  end
end
