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
  resources :users, except: [:edit, :update, :destroy] do
    member do
      get 'allotment'
    end
  end
  resources :allotments, except: [:edit] do
    member do
      get 'history'
    end
  end
  resources :issues, except: [:destroy] do
    member do
      get 'resolve'
    end
  end

  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'

  get '/admin/signup', to: 'users#new_admin'
  post '/admin/signup', to: 'users#create_admin'
end
