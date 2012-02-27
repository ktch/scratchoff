MzScratch::Application.routes.draw do

  match '/dashboard', :to => 'admins#dashboard'
    
  root :to => 'tickets#generate'
  resources :prizes

end