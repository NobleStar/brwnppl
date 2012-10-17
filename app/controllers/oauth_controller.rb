class OauthController < ApplicationController
 
  def start
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      @user.delay.update_avatar(provider, Config.send(provider.to_sym).get_user_hash)
      if provider == "facebook"
        @user.oauth_token = Config.facebook.access_token.token
        @user.save
      end
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end

end
