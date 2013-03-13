class Admin::StoriesController < ApplicationController

  before_filter :admins_only

  def index
    render :index
  end

  private
  def admins_only
    if current_user && current_user.is_admin
      return true
    else
      redirect_to :root, :notice => 'Access Restricted!'
    end
  end

end