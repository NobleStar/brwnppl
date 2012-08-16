class Api::UrlFetcherController < ApplicationController
  before_filter :require_login
  before_filter :validate_url, :only => :index
  
  def index
    @data = OpenGraph.fetch(params[:url])
    unless @data
      page = Nokogiri::HTML( HTTParty.get(params[:url], :headers => {"User-Agent" => 'Mozilla/5.0'}) )
      @data = { title: page.title }
    end
    render json: @data.to_json
  end

protected
  def validate_url
    link = URI.parse(params[:url])
    unless %w(http https).include?(link.scheme)
      render json: { error: 'Invalid Url' }, status: :unprocesable_entity
    end
  end

end