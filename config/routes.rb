Rails.application.routes.draw do
  get 'ratings/index'

  get 'ratings/show'

  get 'ratings/new'

  get 'ratings/edit'

  get 'reviews/index'

  get 'reviews/show'

  get 'reviews/new'

  get 'reviews/edit'

  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :users do
    resources :bookings
  end
  resources :bookings do
    resources :reviews
  end  
  resources :bookings do
    resources :ratings
  end  
  resources :bookings do
    patch :update_confirmed, on: :member
  end
  
  resources :bookings do
    patch :update_reviewed, on: :member
  end
  
end