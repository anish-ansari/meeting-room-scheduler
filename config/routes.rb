Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'

  resources :rooms do
    resources :bookings, except: %i[index update destroy edit]
  end
  resources :bookings, only: [:index]
end
