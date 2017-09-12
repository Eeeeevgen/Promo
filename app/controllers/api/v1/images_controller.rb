module Api
  module V1
    class ImagesController < Api::V1::BaseController
      def index
        images = Image.ordered_by_rating
        render json: images
      end

      def show
        image = Image.find_by(id: params[:id])
        if image
          if image.accepted? || (current_user && current_user.id == image.user_id)
            render json: image
          else
            head 401
          end
        else
          head 404
        end
      end

      def create
        authorize [:api, :v1, Image]
        if params[:image]
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
        LB.remove_member(image.id)
        render json: { image: image, status: :destroyed }
      end
    end
  end
end
