class Admin::BooksController < Admin::AdminController
  def index
    @books = Book.attributes_select.order_by_created_at
      .paginate :page => params[:page], :per_page => Settings.per_page
  end
end
