class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_communities

  protected
  def load_communities
    @communities = Community.all
  end
end
