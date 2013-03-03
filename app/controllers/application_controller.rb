class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_communities
  before_filter :prepare_for_mobile

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end

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
