class Api::V1::UsersController < Api::V1::BaseController
  def index
    users = User.all
    render json: users, each_serializer: UserIndexSerializer
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)

    @user = User.new(user_params)
    @user.token = SecureRandom.urlsafe_base64

    if @user.save
      render json: { status: :user_created }, status: 201
      current_user_session.destroy
    else
      render json: { status: :user_creating_error, errors: @user.errors }, status: 400
    end
  end

  def destroy
    user = User.find_by(params[:id])
    authorize [:api, :v1, user]
    user.destroy
    render json: { user: user, status: :destroyed }, status: 200
  end

  def token  # { "user": { "email": "123@123.ru", "password": "123123123" } }
    user_params = params.require(:user).permit(:email, :password)

    @user_session = UserSession.new(user_params)
    if @user_session.save
      token = UserSession.find.user.token
      render json: { token: token }, status: 200
      @user_session.destroy
    else
      render json: { status: :didnt_authenticate }, status: 401
    end
  end

  def token_destroy
    authorize [:api, :v1, User]
    current_user.token = SecureRandom.urlsafe_base64
    current_user.save
    render json: { status: :token_destroyed }, status: 200
  end
end
