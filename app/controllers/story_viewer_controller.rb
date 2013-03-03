class StoryViewerController < ApplicationController

  layout "iframe"
  def index
    @story = Story.where(slug: params[:slug]).first
  end

end