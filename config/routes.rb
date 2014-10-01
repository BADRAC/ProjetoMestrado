Books::Application.routes.draw do

  resources :buscas  
  resources :books
  resources :articles
  resources :authors
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :keywords
 
  resources :journals do
    resources :editions
  end

  resources :editions do
    resources :articles
  end

  resources :articles do
    resources :keywords 
  end   

  resources :articles do
    resources :authors 
  end 

  root to: 'buscas#index'

  match '/dica',      to: 'buscas#dica',          via: 'get'
  match '/sobre',     to: 'buscas#sobreprojeto',  via: 'get'
  match '/contato',   to: 'buscas#contato',       via: 'get'
  match '/signup',    to: 'users#new',            via: 'get'
  match '/signin',    to: 'sessions#new',         via: 'get'
  match '/signout',   to: 'sessions#destroy',     via: 'delete'
  match '/tutorial',  to: 'journals#tutorial',    via: 'get'
  
end
