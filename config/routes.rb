MzScratch::Application.routes.draw do

  root :to => 'ticket#home'
  resources :prizes

end
