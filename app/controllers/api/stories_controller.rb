class Api::StoriesController < Api::BaseController

  skip_before_filter :require_login, only: [:index, :create]

  def index
    @stories = Story.latest.includes(:user).limit(10)
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
    @story.oauth_token = session[:oauth_token]
    if @story.save
      render json: @story.to_json
    else
      render json: { message: :failed, errors: @story.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @story = Story.find(params[:id])
  end

end