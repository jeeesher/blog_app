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
    get "dashboard" => "dashboard#index"
    resources :posts, only: [:index, :show, :destroy] do
      collection do
        delete :destroy_all
      end
    end

    resources :comments, only: [:index, :edit, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end
  end
end
