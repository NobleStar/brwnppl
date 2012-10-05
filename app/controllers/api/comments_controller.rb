class Api::CommentsController < Api::BaseController

  def create
    @story = Story.find(params[:story_id])
    @story.comments << Comment.create(:content => params[:content], :user_id => current_user.id)
    render json: @story.to_json(:methods => [:likes_count, :avatar])
  end

end