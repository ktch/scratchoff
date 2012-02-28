MzScratch::Application.routes.draw do
  
  resources :admins
  resources :prizes
  resources :sessions, :only => [:new, :create, :destroy]
  
  root :to => 'tickets#generate'

  match '/dashboard', :to => 'admins#dashboard'
  match '/signup',    :to => 'admins#new'
  match '/signin',    :to => 'sessions#new'
  match '/signout',   :to => 'sessions#destroy'

end