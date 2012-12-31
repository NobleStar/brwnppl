class HomeController < ApplicationController

  before_filter :account_setup_needed?

  def index
    @stories = Story.last(25).reverse
  end

  def recent
    @stories = Story.recents
  end

  def popular
    @stories = Story.populars
    render :recent
  end

  def community
    @stories = Story.by_community(params[:slug])
    render :recent
  end

  protected
  def account_setup_needed?
    if current_user && current_user.new_user?
      redirect_to :setup_account, :notice => 'You need to choose a username before you can start using Brwnppl'
    end
  end

end