class Admin::BooksController < Admin::AdminController

  def index
    @books = Book.select_fields.order_by_created_at
      .page(params[:page]).per Settings.books.per_page
  end
end
