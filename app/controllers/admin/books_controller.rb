class Admin::BooksController < Admin::AdminController
  before_action :load_categories, :load_authors, :load_publishers, only: :new

  def index
    @books = Book.attributes_select.order_by_created_at
      .page(params[:page]).per Settings.books.per_page
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

  private

  def book_params
    params.require(:book).permit :title, :category_id, :img_url,
      :publisher_id, :description, :price, :discount, author_ids: []
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
