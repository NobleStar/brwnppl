class Api::UrlFetcherController < ApplicationController
  before_filter :require_login
  
  def index
    @data = OpenGraph.fetch(params[:url]) 
    if @data == false
    	@data = {:title =>  HTTParty.get(params['url']).match(/<title>(.*?)<\/title>/)[1].to_s }
    end
    render json: @data.to_json
  end
end