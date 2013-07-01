class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  before_filter :load_communities
  # before_filter :prepare_for_mobile

  private

  def mobile_device?
    request.user_agent =~ /Mobile|webOS|iPhone/
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    if mobile_device?
      prepend_view_path "app/views/mobile"
    end
  end

  protected
  def load_communities
    @disqus_sso = disqus_sso(current_user) if current_user.present?
    @communities = Community.all
  end

  def account_setup_needed?
    if current_user && current_user.new_user?
      redirect_to :setup_account, :alert => 'You need to setup your account before you can start using Brwnppl'
    end
  end

end
