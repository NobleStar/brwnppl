class Api::CommunitiesController < Api::BaseController
  
  def index
    @communities = Community.all  
  end

end