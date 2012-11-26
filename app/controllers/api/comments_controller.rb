class Api::CommentsController < Api::BaseController

  def create
    @story = Story.find(params[:story_id])
    @comment = @story.comments.build(:content => params[:content], :user => current_user ) 
    if @story.save
      Pusher[@story.id.to_s].trigger('new-comment', comment: [:name => @comment.name, :avatar => @comment.avatar, :content => @comment.content].to_json )
      render 'create.json'
    else
      render json: false
    end
  end

end