require 'uri'

class MainController < ApplicationController
  def index
    # @images = Image.where(aasm_state: :accepted).order(likes_count: :desc).page(params[:page]).per(@per_page)
    if request.get?
      @per_page = params[:per] || 8 #cookies[:per_page]
      @images = Image.where(aasm_state: :accepted).sort_by { |image| LB.rank_for(image.id) }
      @images = Kaminari.paginate_array(@images).page(params[:page]).per(@per_page)
    elsif request.post?
      redirect_to root_path(per: params[:per])
    end
  end

end
