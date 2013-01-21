class UsersController < ApplicationController

  before_filter :require_login, except: :show
  before_filter :account_setup_needed?, except: :update
  before_filter :account_should_be_new, only: :update
  before_filter :same_user?, only: :edit

  def show
    @user = User.find_by_username(params[:username])
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      @user.setup_account
      redirect_to :root, :notice => 'Successfully updated user account!'
    else
      render 'oauth/setup_account'
    end
  end

  def edit
    render 'oauth/setup_account'
  end

  def follow
    @user = User.find_by_username(params[:id])
    if current_user.follow!(@user)
      redirect_to user_profile_url(@user.username), :notice => "You are now following #{@user.username}"
    end
  end

  def unfollow
    @user = User.find_by_username(params[:id])
    if current_user.unfollow!(@user)
      redirect_to user_profile_url(@user.username), :notice => "You've stopped following #{@user.username}"
    end
  end

  protected
  def account_should_be_new
    @user = User.find(params[:user][:id])
    @user.new_user?
  end

  def same_user?
    @user = User.find_by_username(params[:username])
    if @user == current_user
      true
    else
      redirect_to :root, alert: 'Access is restricted to this resource! Event has been logged.'
    end
  end

end