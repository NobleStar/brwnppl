class Api::ImagesController < Api::BaseController

  def upload
    @response = Cloudinary::Uploader.upload(params[:image])
    render :json => @response
  end

end