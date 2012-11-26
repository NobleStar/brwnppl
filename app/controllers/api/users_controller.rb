class Api::UsersController < Api::BaseController

  skip_before_filter :require_login, :only => [:me]

  def index
    render json: [current_user]
  end

  def show
    render json: User.find_by_username(params[:id])
  end

  def me
    if current_user
  	  render json: current_user, :except => :oauth_token
    else
      render json: false
    end
  end

end