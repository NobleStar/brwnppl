Brwnppl::Application.routes.draw do

  namespace :api do
    resources :stories do
      resources :comments
    end
    resources :url_fetcher
    resources :likes
    resources :communities

    resources :users, :constraints  => { :id => /[0-z\.]+/ } do
    	get :me, :on => :collection
    end

  end
  
  resources :users, :only => [:update]

  match '/setup_account'    => 'oauth#setup_account', :as => :setup_account
  match '/_=_'              => redirect('/')
  match 'story/:slug'       => 'stories#index'
  match 'oauth/callback'    => 'oauth#callback'
  match 'logout'            => 'sessions#destroy',    :as => :logout
  match 'oauth/:provider'   => 'oauth#start',         :as => :auth_at_provider
  match 'v/:slug'           => 'story_viewer#index',  :as => :external_viewer
  
  # Communities Route
  match '/b/:slug'          => 'home#community',      :as => :community

  # Popular and Recent Routes
  match '/popular'          => 'home#popular',        :as => :popular
  match '/recent'           => 'home#recent',         :as => :recent

  match ':username'         => 'users#show'

  root :to => 'home#index'

end
