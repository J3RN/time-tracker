Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :time_entries

  resources :tasks

  resources :projects

  resources :customers
end
