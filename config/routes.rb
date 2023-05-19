Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :kitchens, only: [:index, :show, :new, :create, :destroy, :edit, :update] do
    member do
      delete 'kitchens/', action: :destroy
    end
    resources :bookings, only: [:create]
    resources :reviews, only: [:create, :new]
  end

  resources :bookings, only: [:index, :update] do
  end

  namespace :owner do
    resources :bookings, only: [:index, :create, :update]
  end

  # Other routes...

  # Defines the root path route ("/")

  # root "articles#index"
end
