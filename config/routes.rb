Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'account_activations/edit'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contacts'
  root 'static_pages#home'

  resources :users
  resources :password_resets , only: [:new,:create, :edit,:update]
  resources :account_activations , only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
