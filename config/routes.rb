Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :pets
  resources :users, only: %i[show]
  resources :bookings
end
