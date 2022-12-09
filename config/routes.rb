Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks do
    collection do
      get 'search'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :update]
  namespace :admin do
    resources :users
  end
end
