class Api::CommentsController < Api::BaseController

  def create
    @story = Story.find(params[:story_id])
    @comment = @story.comments.build(:content => params[:content], :user => current_user, :socket_id => params[:socket_id] ) 
    if @story.save
      render 'create.json'
    else
      render json: false
    end
  end

end