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
      render json: { story: @story.to_json, header: 'You are awesome!', messages: ['You are awesome! Keep posting more stuff!'], saved: true }
    else
      render json: { header: 'Uh-oh! Let\'s fix this up buddy, shall we?', messages: @story.errors.full_messages, saved: false }
    end
  end

  def update
    @story = Story.find(params[:id])
  end

end