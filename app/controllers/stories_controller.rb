class StoriesController < ApplicationController

  # layout "permalink"
  def index
    @story = Story.find(params[:slug]) 
  end

end