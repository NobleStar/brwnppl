class Api::ImagesController < Api::BaseController

  def upload
    @response = Cloudinary::Uploader.upload(params[:image]) rescue nil
    if @response
      @response = @response.merge( 'user_thumbnail' => "#{view_context.cloudinary_url(@response['public_id'], :height => 223, :gravity => :face, :crop => :thumb, :quality => 80)}.#{@response['format']}" )
      render json: @response
    else
      render json: :failed, status: :unprocessable_entity
    end
  end

  def update
    upload
  end

end