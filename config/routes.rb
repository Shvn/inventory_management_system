Rails.application.routes.draw do
  get 'category/index'

  resources :categories
  resources :brands

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
