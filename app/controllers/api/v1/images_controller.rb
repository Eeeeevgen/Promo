class Api::V1::ImagesController < Api::V1::BaseController
  before_action :authenticate

  def show
    image = Image.find(params[:id])
    render json: image
  end

  def index
    images = Image.all.order(likes_count: :desc)
    render json: images
  end

  def create
    # ?
  end 

  def destroy
    image = Image.find(params[:id])
    authorize [:api, :v1, image]
    image.destroy
    render json: {image: image, status: :destroyed}
  end
end

# request['authorization'] = "Token token=#{token}"