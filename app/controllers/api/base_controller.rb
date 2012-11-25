class Api::BaseController < ApplicationController
  before_filter :require_login
  skip_before_filter :load_communities
end