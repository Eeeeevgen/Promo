class ImagesController < ApplicationController
  def new; end

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
    if params[:images]
      params[:images].each do |image|
        i = current_user.images.new
        i.image = image
        i.save
      end
    end
    params[:id] = current_user.id
    redirect_to user_path(current_user.id)
  end

  def comment
    Comments::Create.run(params.fetch(:comment, {}))
    redirect_back(fallback_location: root_path)
  end

  def delete
    Images::Delete.run(id: params[:id].to_i, current_user: current_user)
    redirect_to user_path(current_user)
  end
end
