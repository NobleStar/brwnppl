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
    if current_user.is_admin && params[:username].present?
      user = User.find_or_create_by_username(params[:username])
      user.attributes = { :email => "#{params[:username]}@brwnppl.com", :bio => '.', :avatar => 'http://brwnppl.herokuapp.com/assets/default_user_image.jpg'}
      user.save
      @story.user = user
    else
      @story.user = current_user
    end
    @story.oauth_token = session[:oauth_token]
    if @story.save
      render json: { story: @story.to_json, header: 'Thanks for sharing!', messages: ['You can review your post by clicking \'Recent\' or \'Me\'. Remember the more you share, the more brwni points you can earn.'], saved: true }
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