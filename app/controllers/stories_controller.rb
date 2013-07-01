class StoriesController < ApplicationController

  # layout "permalink"

  def index
    @story = Story.find_by_slug(params[:slug])
    Disqus.new.sync_comment_count(@story)
  end

end