class Api::StoriesController < Api::BaseController

  skip_before_filter :require_login, only: :index

  def index
    @stories = Story.all
    render json: @stories  
  end

end