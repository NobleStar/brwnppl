class Api::ReshareController < Api::BaseController

  def create
    @story = Story.find(params[:story_id])
    if @story.reshare(current_user)
      render json: { story: @story.to_json, header: 'You are awesome!', messages: ['Your story was reshared successfully!'], saved: true }
    else
      render json: { header: 'Uh-oh! Let\'s fix this up buddy, shall we?', messages: @story.errors.full_messages, saved: false }
    end
  end

end