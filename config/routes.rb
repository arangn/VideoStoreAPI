Rails.application.routes.draw do
  resources :customers, only: [:index, :show, :create]
  resources :movies, only: [:index, :show, :create]


  



end
