MzScratch::Application.routes.draw do

  devise_for :admins, :path => 'admin', :path_names => { :sign_in => 'login', :sign_up => 'new', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification' }, :controllers => { :sessions => "admins/sessions" }

  match '/dashboard', :to => 'admins#dashboard'
    
  root :to => 'tickets#generate'
  resources :prizes

end