MzScratch::Application.routes.draw do
  
  require 'subdomain'
  
  resources :admins
  resources :prizes
  resources :sessions, :only => [:new, :create, :destroy]
  
  constraints(Subdomain) do
    match '/' => 'admins#generate'
  end
  
  root :to => 'admins#marketing'

  match '/dashboard', :to => 'admins#dashboard'
  match '/signup',    :to => 'admins#new'
  match '/signin',    :to => 'sessions#new'
  match '/signout',   :to => 'sessions#destroy'

end