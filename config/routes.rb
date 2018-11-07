Rails.application.routes.draw do

  resources :customers, only: [:index, :show, :create]
  resources :movies, only: [:index, :show, :create]
  resources :rentals, only: [:index, :show, :create]
  post '/rentals/check-out', to: 'rentals#create'
end
# get 'recipes', to: 'recipes#index', as: 'recipes'
