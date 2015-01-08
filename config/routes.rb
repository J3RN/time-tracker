Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :time_entries do
    get 'stop_time', on: :member
  end

  resources :tasks

  resources :projects

  resources :customers
end
