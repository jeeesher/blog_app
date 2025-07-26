Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "posts#index"

  resources :posts do
    collection do
      get :my_posts
    end
    resources :comments, only: [:create, :edit, :update, :destroy]
  end

  resources :posts do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end
  
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  namespace :admin do
    get "comments/index"
    get "comments/edit"
    get "posts/index"
    get "dashboard", to: "dashboard#index"
    resources :posts, only: [:index, :destroy]
    resources :comments, only: [:index, :edit, :update, :destroy]
  end
end
