class StoriesController < ApplicationController

  # layout "permalink"
  def index
    @story = Story.find_by_slug(params[:slug]) 
  end

end