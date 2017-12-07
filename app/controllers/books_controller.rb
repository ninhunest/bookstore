class BooksController < ApplicationController
  before_action :load_meta_data, only: :index
  before_action :filter, only: :index
  before_action :load_book, only: :show
  before_action :load_meta_data_for_current_book, only: :show

  def index
    @books = @books.select_fields.order_by_created_at
      .page(params[:page]).per Settings.books.per_page
  end

  def show
    @comment = @book.comments.build
  end

  private

  def filter
    @books = Book.all

    if params[:search].present?
      if params[:search][:category].present?
        filter_by_category
      end

      if params[:search][:author].present?
        filter_by_author
      end

      if params[:search][:publisher].present?
        filter_by_publisher
      end

      if params[:search][:title].present?
        @books = @books.find_by_title params[:search][:title]
      end

      if params[:search][:price_from].present?
        @books = @books.price_from params[:search][:price_from]
      end

      if params[:search][:price_to].present?
        @books = @books.price_to params[:search][:price_to]
      end
    end
  end

  def filter_by_category
    category = Category.find_by id: params[:search][:category]
    check_valid category
    book_ids = category.books.pluck :id
    @books = @books.where_in book_ids
  end

  def filter_by_author
    author = Author.find_by id: params[:search][:author]
    check_valid author
    book_ids = author.books.pluck :id
    @books = @books.where_in book_ids
  end

  def filter_by_publisher
    publisher = Publisher.find_by id: params[:search][:publisher]
    check_valid publisher
    book_ids = publisher.books.pluck :id
    @books = @books.where_in book_ids
  end

  def check_valid object
    return if object.nil?
  end

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
