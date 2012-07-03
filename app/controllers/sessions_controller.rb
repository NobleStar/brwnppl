class SessionsController < ApplicationController

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end

end