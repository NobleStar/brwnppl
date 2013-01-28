class HomeController < ApplicationController

  before_filter :account_setup_needed?
  skip_before_filter :account_setup_needed?, :only => [:privacy_policy, :user_agreement]
  skip_before_filter :require_login, :except => :my_brwnppl

  caches_action :popular, :cache_path => :popular_cache.to_proc
  caches_action :index, :recent, :cache_path => :recent_cache.to_proc

  def index
    @stories = Story.latest.page(params[:page])
  end

  def recent
    @stories = Story.latest.page(params[:page])
  end

  def popular
    @stories = Kaminari.paginate_array( Story.populars ).page(params[:page])
    render :recent
  end

  def my_brwnppl
    @stories = Story.recent_for( current_user.followed_users.map(&:id) )
    @stories = Kaminari.paginate_array( @stories ).page(params[:page])
    render 'recent'
  end

  def privacy_policy
    render 'static_pages/privacy_policy'
  end

  def user_agreement
    render 'static_pages/user_agreement'
  end

  def guidelines
    render 'static_pages/community_guidelines'
  end

  def recent_community
    @community = Community.find_by_slug(params[:slug])
    if @community
      @stories = Kaminari.paginate_array( Story.recent_by_community(@community) ).page(params[:page])
      render :recent
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def community
    @community = Community.find_by_slug(params[:slug])
    if @community
      @stories = Kaminari.paginate_array( Story.by_community(@community) ).page(params[:page])
      render :recent
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def popular_cache
    return if flash.keys.present?
    if current_user
      "logged_in/popular/#{current_user.id}"
    else
      "logged_out/popular"
    end
  end

  def recent_cache
    return if flash.keys.present?
    if current_user
      "logged_in/recent/#{current_user.id}"      
    else
      "logged_out/recent"
    end
  end

end