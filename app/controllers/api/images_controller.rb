class Api::ImagesController < Api::BaseController

  def upload
    @response = Cloudinary::Uploader.upload(params[:image]) rescue nil
    if @response
      render json: @response
    else
      render json: :failed, status: :unprocessable_entity
    end
  end

end