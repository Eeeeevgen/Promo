class Api::V1::ImagesController < Api::V1::BaseController
  def index
    images = Image.all.order(likes_count: :desc)
    render json: images
  end

  def show
    image = Image.find(params[:id])
    render json: image
  end

  def create
    authorize [:api, :v1, Image]
    if params[:image]
      # current_user.images.create(params[:image]) # doesn't work?
      i = current_user.images.new
      i.image = params[:image]
      i.save
    end
    render json: { status: :uploaded }
  end

  def destroy
    image = Image.find(params[:id])
    authorize [:api, :v1, image]
    image.destroy
    LeaderboardI::Delete.run(image_id: image.id)
    render json: { image: image, status: :destroyed }
  end
end

# request['authorization'] = "Token token=#{token}"
