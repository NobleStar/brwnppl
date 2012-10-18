Brwnppl::Application.routes.draw do

  namespace :api do
    resources :stories do
      resources :comments
    end
    resources :url_fetcher
    resources :likes

    resources :users, :constraints  => { :id => /[0-z\.]+/ } do
    	get :me, :on => :collection
    end

  end
  
  match '/_=_' => redirect('/')
  match 'story/:slug' => 'stories#index'
  match 'oauth/callback'    => 'oauth#callback'
  match 'logout'            => 'sessions#destroy',    :as => :logout
  match 'oauth/:provider'   => 'oauth#start',         :as => :auth_at_provider
  match 'v/:slug'           => 'story_viewer#index',  :as => :external_viewer
  match ':username' => 'home#index'

  root :to => 'home#index'

end
