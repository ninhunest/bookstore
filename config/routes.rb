Rails.application.routes.draw do
  root "books#index"
  devise_for :users
  namespace :admin do
    resources :books
  end
end
