class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Account registered!"
      redirect_to root_path
    else
      puts '1111'
      render :new
    end
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :lang)
    end
end
