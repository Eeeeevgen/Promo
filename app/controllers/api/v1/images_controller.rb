class Api::V1::ImagesController < Api::V1::BaseController
  def show
    image = Image.find(params[:id])
    render json: image
  end

  def index
    images = Image.all.order(likes_count: :desc).limit(10)
    render json: images
  end
end