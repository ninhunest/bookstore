Rails.application.routes.draw do
  root "books#index"
  devise_for :users

  resources :books
  resources :comments
  resources :line_items do
    collection do
      delete "remove_from_index/:id", to: "line_items#remove_from_index",
        as: "remove_from_index"
    end
  end

  resources :carts
  resources :orders

  namespace :admin do
    resources :books
  end
end
