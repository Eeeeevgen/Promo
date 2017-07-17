class UsersController < ApplicationController
  attr_accessor :password, :password_confirmation

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    @user.token = SecureRandom.urlsafe_base64
    if @user.save
      flash[:success] = "Account registered!"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @images = @user.images.page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def avatar
    current_user.avatar = params[:image]
    current_user.save
    flash[:success] = "Avatar updated"
    redirect_to edit_user_path(current_user)
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :token)
    end
end
