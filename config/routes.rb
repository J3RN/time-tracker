Rails.application.routes.draw do
  resources :time_entries

  resources :tasks

  resources :projects

  resources :customers

  devise_for :users

  root to: 'home#index'
end
