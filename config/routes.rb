Rails.application.routes.draw do
  resources :zones do
    resources :bookings
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
end