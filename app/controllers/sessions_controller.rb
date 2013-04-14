class SessionsController < ApplicationController

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end

  def new
    @user = User.new
  end

  def create
    respond_to do |format|
      if @user = login(params[:email],params[:password],params[:remember])
        format.html { redirect_to :root, :notice => 'Welcome back to Brwnppl. You\'ve successfully logged in!' }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
      end
    end
  end

end