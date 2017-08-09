Rails.application.routes.draw do
  root 'welcome#index'

  resources :items, except: :destroy do
    member do
      get 'allotment'
      get 'history'
    end
  end
  resources :categories
  resources :brands
  resources :users, only: [:new, :create]
  resources :people, only: [:index, :new, :create] do
    member do
      get 'allotment'
      get 'history'
    end
  end
  resources :allotments, except: [:edit] do
    member do
      get 'history'
    end
  end

  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
end
