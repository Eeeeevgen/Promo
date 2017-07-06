require 'pp'

class MainController < ApplicationController
  def index
    @top = LbTop.run!
    # @images = Image.all.order(likes_count: :desc).paginate(page: params[:page], :per_page => 6)
    @images = Image.where(aasm_state: :accepted).order(:likes_count).reverse_order.paginate(page: params[:page], :per_page => 6)
  end

  def test
    @user = current_user
    render json: @user
  end
end
