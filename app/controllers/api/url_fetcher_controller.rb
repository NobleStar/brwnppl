class Api::UrlFetcherController < ApplicationController
  before_filter :require_login, :except => :index

  def index
    @data = Brwnppl::UrlFetcher.new(params[:url], params[:type])
    render json: @data.to_json
  end

end