class Api::StoriesController < Api::BaseController

  skip_before_filter :require_login, only: :index

  def index
    @stories = Story.includes(:user).limit(10)
    render json: @stories.to_json(:include => :user)
  end

  def create
    @story = Story.new(params[:story])
    @story.user = current_user
    if @story.save
      render json: @story.to_json
    else
      render json: { status: :unprocessable_entity, message: :failed }
    end
  end

end