Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :pets
  resources :users, only: %i[show]
  resources :bookings

  get "/cats", to: "pets#cats", as: :cats
  get "/dogs", to: "pets#dogs", as: :dogs
end
