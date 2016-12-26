Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
  get 'password_resets/new'

  get 'password_resets/edit'

  resources :posts
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :comments,          only: [:create, :destroy, :edit, :update, :index]
  resources :sessions, only: [:create, :destroy]

  get 'sessions/new'

  root 'posts#index'

  
  post '/signup',  to: 'users#create'
  get  '/signup',  to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  

  post '/rate_post',  to: 'posts#rate'
  
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  

end
