MzScratch::Application.routes.draw do

  devise_for :admins, :path => 'admin', :path_names => { :sign_in => 'login', :sign_up => 'new', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification' }

  root :to => 'ticket#generate'
  resources :prizes

end
