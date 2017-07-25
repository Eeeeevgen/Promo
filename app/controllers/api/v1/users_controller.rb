class Api::V1::UsersController < Api::V1::BaseController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    users_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)

    @user = User.new(users_params)
    @user.token = SecureRandom.urlsafe_base64

    if @user.save
      render json: { status: :user_created }, status: 201
      current_user_session.destroy
    else
      render json: { status: :user_creating_error, errors: @user.errors }, status: 400
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize [:api, :v1, user]
    user.destroy
    render json: { user: user, status: :destroyed }, status: 200
  end
end
