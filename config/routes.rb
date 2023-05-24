Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]

  resources :events do
    resources :attendances
    resources :event_pictures, only: [:create]
    patch :update_true, on: :member
    patch :update_false, on: :member
  end

  root to: 'events#index'

  namespace :admin do
      root to: 'users#index'
      resources :users, :events, :attendances
  end

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

end
