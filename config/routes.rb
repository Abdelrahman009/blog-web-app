Rails.application.routes.draw do
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'users/new'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contacts'
  get 'users' => 'users#new'
  root 'static_pages#home'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
