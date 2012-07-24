Brwnppl::Application.routes.draw do

  namespace :api do
    resources :stories
    resources :url_fetcher

    resources :users, :constraints  => { :id => /[0-z\.]+/ } do
    	get :me, :on => :collection
    end

  end

  match 'oauth/callback'    => 'oauth#callback'
  match 'logout'            => 'sessions#destroy',  :as => :logout
  match 'oauth/:provider'   => 'oauth#start',       :as => :auth_at_provider
  
  root :to => 'home#index'

end
