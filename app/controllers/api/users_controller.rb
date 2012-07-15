class Api::UsersController < Api::BaseController

  def index
    render json: current_user  
  end

end