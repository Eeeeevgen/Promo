class MainController < ApplicationController
  def index
    @images = Image.all.paginate(page: params[:page], :per_page => 6)
  end

  def test
    @comments = Comment.all
  end
end
