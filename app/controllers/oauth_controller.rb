class OauthController < ApplicationController

  def start
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      #@user.delay.update_avatar(provider, Config.send(provider.to_sym).get_user_hash)
      if provider == "facebook"
        @user.oauth_token = Config.facebook.access_token.token
        @user.save
      end
      redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_and_validate_from(provider)
        @user.username = Config.facebook.get_user_hash[:user_info]['id']
        @user.bio = 'short bio'
        if provider == "facebook" && @user.valid?
          @user.oauth_token = Config.facebook.access_token.token
          @user.save
        end
        @user.update_avatar(provider, Config.send(provider.to_sym).get_user_hash)
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to setup_account_path, :notice => "Logged in from #{provider.titleize}!"
      rescue => e
        puts e.inspect
        puts e.to_yaml
        redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
      end
    end
  end

  def setup_account
    @user = current_user
    redirect_to :root if @user.setup_completed?
  end

end
