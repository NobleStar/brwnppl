class Api::AbuseController < Api::BaseController
  
  skip_before_filter :require_login

  def create
    @story = Story.find(params[:story_id])
    if @story.report_abuse
      render nothing: true, status: :ok
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

end