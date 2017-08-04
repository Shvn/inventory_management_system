Rails.application.routes.draw do
  root 'welcome#index'

  resources :items, except: :destroy
  resources :categories
  resources :brands
  resources :users, only: [:new, :create]

  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
end
