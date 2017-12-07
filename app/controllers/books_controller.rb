class BooksController < ApplicationController
  before_action :load_meta_info, only: :index

  def index
    @books = Book.select_fields.order_by_created_at
      .page(params[:page]).per Settings.books.per_page
  end

  def show; end

  private

  def load_meta_info
    @categories = Category.hot_categories
    @authors = Author.hot_authors
    @publishers = Publisher.hot_publishers
  end
end
