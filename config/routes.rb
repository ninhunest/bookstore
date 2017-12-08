Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  root "books#index"
  devise_for :users

  resources :books
  resources :comments
  resources :line_items do
    collection do
      delete "remove_from_index/:id", to: "line_items#remove_from_index",
        as: "remove_from_index"

      post "update_quantity", to: "line_items#update_quantity",
        as: "update_quantity"
    end
  end

  resources :carts
  resources :orders

  namespace :admin do
    resources :books
    resources :categories
    resources :publishers
    resources :authors
  end
end
