Rails.application.routes.draw do
<<<<<<< 06d50b2ec7d819782d58d6a74494ec6c3abb3ae4
  get 'welcome/index'

  root 'welcome#index'

  resources :items, except: :destroy
  resources :categories
  resources :brands

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
=======
  resources :users
>>>>>>> Made skeleton of user manipulation in the system
end
