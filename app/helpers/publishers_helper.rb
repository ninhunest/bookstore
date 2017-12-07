module PublishersHelper
  def load_publishers
    @publishers = Publisher.select_fields.order_by_name
  end

  def show_publisher_param
    (params[:search].present? && params[:search][:publisher].present?) ?
      params[:search][:publisher] : nil
  end
end
