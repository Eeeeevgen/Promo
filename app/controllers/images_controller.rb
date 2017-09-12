class ImagesController < ApplicationController
  def new; end

  def index
    @per_page = params[:per] || 8
    @images = Image.includes(:user).ordered_by_rating
    @images = Kaminari.paginate_array(@images).page(params[:page]).per(@per_page)
  end

  def show
    @image = Image.find(params[:id])
    @comments = @image.comments.hash_tree
    @comment = Comment.new
  end

  def like
    authorize image = Image.find(params[:id])
    LeaderboardI::LikeImage.run(image_id: params[:id], image: image, current_user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def upload
    params[:images].try(:each) do |image|
      i = current_user.images.new
      i.image = image
      i.save
    end
    params[:id] = current_user.id
    redirect_to user_path(current_user.id)
  end

  def comment
    Comment.create(params.require(:comment).permit(:text, :parent_id, :image_id, :user_id))
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Images::Delete.run(id: params[:id].to_i, current_user: current_user)
    redirect_to user_path(current_user)
  end
end
