Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :time_entries, except: :show do
    collection do
      get 'report'
      get 'export'
      get :updates_all_time_entries
    end

    member do
      get 'stop_time'
      get 'start_time'
    end
  end

  resources :tasks, except: :show do
    member do
      get 'archive'
      get 'unarchive'
    end
  end
  resources :tags, except: :show
end
