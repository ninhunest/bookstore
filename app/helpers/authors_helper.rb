module AuthorsHelper
  def load_authors
    @authors = Author.select_fields.order_by_name
  end

  def show_author_param
    (params[:search].present? && params[:search][:author].present?) ?
      params[:search][:author] : nil
  end
end
