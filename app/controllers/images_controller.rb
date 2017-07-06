class ImagesController < ApplicationController
  def new
  end

  def show
    @image = Image.find(params[:id])
    @comments = Comment.where(:image_id => params[:id]).hash_tree
    @comment = Comment.new
  end

  def like
    authorize image = Image.find(params[:id])
    LbLike.run(image_id: params[:id], image: image)
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
    CreateComment.run(params.fetch(:comment, {}))
    redirect_back(fallback_location: root_path)
  end

  def delete
    ImageDelete.run(id: params[:id].to_i)
    redirect_to user_path(current_user)
  end
end