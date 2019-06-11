Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get 'home', to: 'pages#index'
  root to: "pages#index"

  resources :reviews
  resources :categories do
    member do
      get :services
    end
  end
  resources :services
  resources :favorites, only: [:create, :destroy]


  resources :users, only: [:new, :create, :update], as: "onboarding", path: "seller_onboarding"
  resources :users, only: [:show], as: "profile", path: "profile"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end