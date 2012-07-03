Brwnppl::Application.routes.draw do

  match 'oauth/callback'    => 'oauth#callback'
  match 'logout'            => 'sessions#destroy',  :as => :logout
  match 'oauth/:provider'   => 'oauth#start',       :as => :auth_at_provider
  
  root :to => 'home#index'

end
