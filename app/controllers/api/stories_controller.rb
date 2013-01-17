class Api::StoriesController < Api::BaseController

  skip_before_filter :require_login, only: [:index, :show]

  def index
    @stories = Story.latest.includes(:user).limit(10)
  end

  def show
    @story = Story.find(params[:id])
    if @story
      render 'show.json'
    else
      render json: { message: :not_found }, status: :unprocessable_entity
    end
  end

  def create
    class_type = params[:story][:type] || "Story"
    @story = class_type.constantize.new(params[:story])
    @story.user = current_user
    @story.oauth_token = session[:oauth_token]
    if @story.save
      render json: { story: @story.to_json, header: 'Thanks for sharing!', messages: ['Feel free to take a screen shot of this message, print it out, and add it to your scrap book.'], saved: true }
    else
      render json: { header: 'Slow Down Cowboy!', messages: @story.errors.full_messages, saved: false }
    end
  end

  def update
    @story = Story.find(params[:id])
  end

  def destroy
    @story = Story.find(params[:id])
    if @story.user == current_user && @story.destroy
      redirect_to :root, :notice => "Your post was deleted successfully."
    else
      redirect_to :root, :alert => "There was some problem, we were unable to delete your post"
    end
  end

end