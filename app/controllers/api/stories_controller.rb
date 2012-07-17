class Api::StoriesController < Api::BaseController

  skip_before_filter :require_login, only: :index

  def index
    @stories = Story.includes(:user).all
    render json: @stories.to_json(:include => :user)
  end

end