class BooksController < ApplicationController
  before_action :load_meta_data, only: :index
  before_action :load_book, only: :show
  before_action :load_meta_data_for_current_book, only: :show

  def index
    @books = Book.select_fields.order_by_created_at
      .page(params[:page]).per Settings.books.per_page
  end

  private

  def load_meta_data
    @categories = Category.hot_categories
    @authors = Author.hot_authors
    @publishers = Publisher.hot_publishers
  end

  def load_meta_data_for_current_book
    @comments = Comment.load_comment(@book).except_reply.select_fields
      .order_by_created_at.limit Settings.comments.limit
    @authors = @book.authors

    if @book.category.present?
      @related_books = @book.category.books.except_current_book(@book)
        .select_fields.limit Settings.related_book.limit
    end
  end

  def load_book
    @book = Book.find_by id: params[:id]

    return if @book
    flash[:danger] = t "book_not_found"
    redirect_to :root
  end
end
