class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate

  def show
    user = User.find(params[:id])
    render json: user
  end

  def index
    users = User.all
    render json: users
  end

  def create
    # ?
  end

  def destroy
    user = User.find(params[:id])
    authorize [:api, :v1, user]
    user.destroy
    render json: {user: user, status: :destroyed}
  end

end