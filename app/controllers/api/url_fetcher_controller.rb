class Api::UrlFetcherController < ApplicationController
  before_filter :require_login
  before_filter :validate_url, :only => :index

  def index
    @data = Brwnppl::UrlFetcher.new(params[:url], params[:type])
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