class BrowseController < ApplicationController

  def popular
    render 'home/recent'
  end

  def top
    render 'home/recent'
  end

  def recent
    render 'home/recent'
  end

end