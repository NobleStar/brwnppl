class Api::UrlFetcherController < ApplicationController
  before_filter :require_login, :except => :index

  def index
    if params[:type] == 'discussion'
      @data = Story.find_by_slug(params[:slug])
    else
      @data = Brwnppl::UrlFetcher.new(params[:url], params[:type])
    end
    render json: @data.to_json
  end

end