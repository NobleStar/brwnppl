class Api::UsersController < Api::BaseController
  helper :application
  skip_before_filter :require_login, :only => [:me]

  def index
    render json: [current_user]
  end

  def show
    @user = User.find_by_username(params[:id])
  end

  def me
    if current_user
      @user = current_user
  	  render 'show.json'
    else
      render json: false, :status => :unprocessable_entity
    end
  end

end