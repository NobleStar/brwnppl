class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_communities

  protected
  def load_communities
    @communities = Community.all
  end

  def account_setup_needed?
    if current_user && current_user.new_user?
      redirect_to :setup_account, :alert => 'You need to setup your account before you can start using Brwnppl'
    end
  end

end
