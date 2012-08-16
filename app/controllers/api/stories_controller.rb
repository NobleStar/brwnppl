class Api::StoriesController < Api::BaseController

  skip_before_filter :require_login, only: [:index, :create]

  def index
    @stories = Story.includes(:user).limit(10)
    render json: @stories.to_json(:include => :user)
  end

  def show
    @story = Story.find(params[:id])
    if @story
      render json: @story.to_json
    else
      render json: { message: :not_found }, status: :unprocessable_entity
    end
  end

  def create
    @story = Story.new(params[:story])
    @story.user = current_user
    if @story.save
      render json: @story.to_json
    else
      render json: { message: :failed, errors: @story.errors.full_messages }, status: :unprocessable_entity
    end
  end

end