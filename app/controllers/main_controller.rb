require 'pp'

class MainController < ApplicationController
  def index
    @top = LbTop.run!
    @images = Image.all.order(likes_count: :desc).paginate(page: params[:page], :per_page => 6)
  end

  def test
    @comment = Comment.new
    @comments = Comment.hash_tree
  end
end
