class Api::LikesController < Api::BaseController

  def create
    @story = Story.find(params[:story_id])
    if @story.liked_by(current_user)
      render json: @story.to_json(:methods => :likes_count)
    else
      render json: { message: :cannot_like }, status: :unprocessable_entity
    end
  end

end