class Api::UsersController < Api::BaseController

  def index
    render json: [current_user]
  end

  def show
    render json: User.find_by_username(params[:id])
  end

  def me
  	render json: current_user
  end

end