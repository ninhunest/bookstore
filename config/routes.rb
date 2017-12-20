Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  root "books#index"
  devise_for :users
  resources :books
  namespace :admin do
    resources :books
    resources :categories
    resources :publishers
  end
end
