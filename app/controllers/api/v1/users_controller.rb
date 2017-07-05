require 'pp'

class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])
    render json: user
  end

  def index
    users = User.all
    render json: users
  end

  # def destroy
  #   pp params
  #   render json: params.to_json
  # end
end