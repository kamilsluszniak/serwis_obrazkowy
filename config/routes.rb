Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  resources :posts
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'sessions/new'

  root 'posts#index'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  
  post '/signup',  to: 'users#create'
  get  '/signup',  to: 'users#new'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  get   '/new_post',  to: 'posts#new'
  patch '/rate_post',  to: 'posts#rate'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  

end
