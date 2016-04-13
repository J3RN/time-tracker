Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  get :dashboard, to: 'home#dashboard'

  resources :time_entries, except: :show do
    collection do
      get 'report'
      get 'export'
    end

    member do
      get 'stop_time'
      get 'start_time'
    end
  end

  resources :tasks, except: [:show, :index]
  resources :tags, except: :show
end
