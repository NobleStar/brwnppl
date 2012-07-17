Brwnppl::Application.routes.draw do

  namespace :api do
    resources :stories
    resources :users, :constraints  => { :id => /[0-z\.]+/ }
  end

  match 'oauth/callback'    => 'oauth#callback'
  match 'logout'            => 'sessions#destroy',  :as => :logout
  match 'oauth/:provider'   => 'oauth#start',       :as => :auth_at_provider
  
  root :to => 'home#index'

end
