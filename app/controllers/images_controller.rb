class ImagesController < ApplicationController
  def new
  end

  def show
    @image = Image.find(params[:id])
    @comments = Comment.where(:image_id => params[:id])
    @comment = Comment.new
  end

  def vote
    @image = Image.find(params[:id])
    @image.likes += 1
    @image.save
    redirect_to root
  end

  def comment
    comment = Comment.new(comments_params)
    comment.save
    redirect_back(fallback_location: root_path)
  end

  private

    def comments_params
      params.require(:comment).permit(:text, :pid, :image_id)
    end
end