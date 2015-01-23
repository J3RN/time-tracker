Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :time_entries do
    get 'report', on: :collection

    member do
      get 'stop_time'
      get 'start_time'
    end
  end

  resources :tasks

  resources :projects

  resources :customers do
    post 'import', on: :collection
  end
end
