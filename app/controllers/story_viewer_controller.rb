class StoryViewerController < ApplicationController

  layout "iframe"
  def index
    @story = Story.find(params[:slug])
  end

end