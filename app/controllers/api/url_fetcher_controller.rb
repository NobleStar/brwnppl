class Api::UrlFetcherController < ApplicationController
  before_filter :require_login
  
  def index
  	
    @data = OpenGraph.fetch(params[:url]) 
    if @data == false
    	coder = HTMLEntities.new
		string = HTTParty.get(params['url']).html_safe.match(/<title>(.*?)<\/title>/)[1]
		@data = {:title => coder.decode(string) }
    end
    render json: @data.to_json
  end
end