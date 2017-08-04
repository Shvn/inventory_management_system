Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  resources :items, except: :destroy
  resources :categories
  resources :brands
  resources :users, only: [:new, :create]

  get '/users/signup', to: 'users#new', as: :signup
end
