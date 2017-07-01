class ImagesController < ApplicationController
  def new
  end

  def show
    @image = Image.find(params[:id])
    @comments = Comment.where(:image_id => params[:id])
    @comments = Comment.where(:image_id => params[:id]).hash_tree
    puts @comments.inspect

    @comment = Comment.new
  end

  def vote
    @image = Image.find(params[:id])
    @image.likes += 1
    @image.save
    redirect_to root
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

  private

    def comments_params
      params.require(:comment).permit(:text, :parent_id, :image_id, :user_id)
    end
end