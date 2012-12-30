class Api::DislikesController < Api::BaseController

  def create
    @story = Story.find(params[:story_id])
    if @story.disliked_by(current_user)
      render json: @story.to_json(:methods => :dislikes_count)
    else
      render json: { message: :cannot_dislike }, status: :unprocessable_entity
    end
  end

end