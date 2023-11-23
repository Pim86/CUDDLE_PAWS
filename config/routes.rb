Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :pets
  resources :users, only: %i[show]
  resources :bookings

  get "/cats", to: "pets#cats", as: :cats
  get "/dogs", to: "pets#dogs", as: :dogs

  resources :bookings, only: %i[index show edit update destroy]
  resources :pets do
    resources :bookings, only: %i[new create]
  end
  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  patch '/profile', to: 'users#update'
end
