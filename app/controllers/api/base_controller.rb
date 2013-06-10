class Api::BaseController < ApplicationController
  before_filter :require_login
  skip_before_filter :load_communities
  skip_before_filter :verify_authenticity_token
end