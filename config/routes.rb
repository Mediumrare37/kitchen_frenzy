Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :kitchens, only: [:index, :show, :new, :create] do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:index, :update]

  namespace :owner do
    resources :bookings, only: :index
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
