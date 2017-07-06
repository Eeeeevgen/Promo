require 'pp'

class MainController < ApplicationController
  def index
    @images = Image.where(aasm_state: :accepted).order(likes_count: :desc).page(params[:page]).per(6)
  end
end
