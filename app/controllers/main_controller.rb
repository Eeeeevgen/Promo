class MainController < ApplicationController
  def index
    @images = Image.all.paginate(page: params[:page], :per_page => 6)
  end

  def test
    # @user = User.find(session[:user_id])
  end
end
