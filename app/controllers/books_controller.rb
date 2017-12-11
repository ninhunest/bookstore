class BooksController < ApplicationController
  before_action :load_meta_info, only: :index
  before_action :load_book, only: :show

  def index
    @books = Book.select_fields.order_by_created_at
      .page(params[:page]).per Settings.books.per_page
  end

  def show
    @authors = @book.authors
    @related_books = @book.category.books.except_current_book(@book)
      .select_fields.limit Settings.related_book.limit
  end

  private

  def load_meta_info
    @categories = Category.hot_categories
    @authors = Author.hot_authors
    @publishers = Publisher.hot_publishers
  end

  def load_book
    @book = Book.find_by id: params[:id]

    return if @book
    flash[:danger] = t "book_not_found"
    redirect_to :root
  end
end
