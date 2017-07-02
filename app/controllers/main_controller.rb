class MainController < ApplicationController
  def index
    @images = Image.all.paginate(page: params[:page], :per_page => 6)
    puts $redis.get('test')
  end

  def test
    @comment = Comment.new
    @comments = Comment.hash_tree
  end
end
