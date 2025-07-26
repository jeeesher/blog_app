Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "posts#index"

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  namespace :admin do
    get "dashboard" => "dashboard#index"
  end
end
