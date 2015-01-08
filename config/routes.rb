Rails.application.routes.draw do
  resources :wickets

  devise_for :users
  root to: 'home#index'

  resource :wicket
end
