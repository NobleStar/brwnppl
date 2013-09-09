class Api::UsersController < Api::BaseController
  helper :application
  skip_before_filter :require_login, :only => [:me, :show]

  def index
    render json: [current_user]
  end

  def show
    @user = User.where_username(params[:id]).first
  end

  def me
    if current_user
      @user = current_user
  	  render 'show.json'
    else
      render json: false, :status => :unprocessable_entity
    end
  end

  def follow
    @user = User.where_username(params[:id]).first
    if current_user.follow!(@user)
      render json: true
    else
      render json: false, status: :unprocessable_entity
    end
  end

  def unfollow
    @user = User.where_username(params[:id]).first
    if current_user.unfollow!(@user)
      render json: true
    else
      render json: false, status: :unprocessable_entity
    end
  end

end