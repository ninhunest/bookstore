module CategoriesHelper
  def load_categories
    @categories = Category.select_fields.order_by_name
  end

  def show_category_param
    (params[:search].present? && params[:search][:category].present?) ?
      params[:search][:category] : nil
  end
end
