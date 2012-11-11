class UsersController < ApplicationController

  before_filter :require_login
  before_filter :account_should_be_new, only: :update

  def show
    @user = User.find_by_username(params[:username])
  end

  def update
    @user = User.find(params[:user][:id])
    if @user.update_attributes(params[:user])
      @user.setup_account
      redirect_to :root, :notice => 'Successfully updated user account!'
    else
      render 'oauth/setup_account'
    end
  end

  protected
  def account_should_be_new
    @user = User.find(params[:user][:id])
    @user.new_user?
  end

end