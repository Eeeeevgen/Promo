class ImagesController < ApplicationController
  def new
  end

  def show
    @image = Image.find(params[:id])
    @comments = Comment.where(:image_id => params[:id]).hash_tree
    @comment = Comment.new
  end

  def like
    LbLike.run(image_id: params[:id], user: current_user)
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
    if params[:comment][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment].delete(:parent_id))
      comment = parent.children.build(comments_params)
    else
      comment = Comment.new(comments_params)
    end

    comment.save
    redirect_back(fallback_location: root_path)
  end

  def delete
    image = current_user.images.find(params[:id])
    if image
      LbDelete.run(image_id: image.id)
      image.destroy

    end
    redirect_to user_path(current_user)
  end

  private

    def comments_params
      params.require(:comment).permit(:text, :parent_id, :image_id, :user_id)
    end
end