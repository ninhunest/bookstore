class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CartsHelper
  include BooksHelper
  include CommentsHelper
  include CategoriesHelper
  include PublishersHelper
  include LineItemsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_order

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:name, :email,
      :password, :avatar)}
    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:name,
      :email, :password, :current_password, :is_female, :date_of_birth,
      :avatar)}
  end
end
