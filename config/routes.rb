Brwnppl::Application.routes.draw do

  namespace :api do
    resources :stories do
      resources :comments
    end
    resources :url_fetcher
    resources :likes
    resources :dislikes
    resources :communities
    resources :reshare

    resources :users, :constraints  => { :id => /[0-z\.]+/ } do
    	get :me, :on => :collection
    end

    resources :images do
      post :upload, :on => :collection
    end

  end
  
  resources :users, :only => [:update] do
    member do
      get :following, :followers
    end
    member do
      get :follow
      get :unfollow
    end
  end

  # Authentication Actions:
  match 'oauth/callback'    => 'oauth#callback'
  match 'oauth/:provider'   => 'oauth#start',         :as => :auth_at_provider
  match 'logout'            => 'sessions#destroy',    :as => :logout
  match '/setup_account'    => 'oauth#setup_account', :as => :setup_account  
  match '/_=_'              => redirect('/')

  # Story Viewers
  match 'story/:slug'       => 'stories#index'
  match '/v/:slug'           => 'story_viewer#index',  :as => :external_viewer
  
  # Communities Route
  match '/b/:slug'          => 'home#community',        :as => :community
  match '/b/:slug/recent'   => 'home#recent_community', :as => :recent_community

  # Popular and Recent Routes
  match '/popular'          => 'home#popular',        :as => :popular
  match '/recent'           => 'home#recent',         :as => :recent

  # Static and Legal Pages:
  match '/help/privacy_policy'   => 'home#privacy_policy', :as => :privacy_policy
  match '/help/user_agreement'   => 'home#user_agreement', :as => :user_agreement
  match '/help/guidelines'       => 'home#guidelines',     :as => :guidelines


  match ':username'         => 'users#show',          :as => :user_profile

  root :to => 'home#popular'

end
