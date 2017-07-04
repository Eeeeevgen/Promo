class UsersController < ApplicationController
  attr_accessor :password, :password_confirmation

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)

    if @user.save
      flash[:success] = "Account registered!"
      redirect_to root_path
    else
      # flash[:danger] = "Some error occured"
      render :new
    end
  end

  def show
    @images = User.find(params[:id].to_i).images.paginate(page: params[:page], :per_page => 6)
  end

  def edit
    @avatar = current_user.avatar
    if @avatar.blank?
      @avatar = "default_avatar.png"
    else
      @avatar = @avatar.url
    end
  end

  def avatar
    current_user.avatar = params[:image]
    current_user.save
    flash[:success] = "Avatar updated"
    redirect_to edit_user_path(current_user)
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
