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
      puts '1111'
      render :new
    end
  end

  def show
    if request.post?
      i = current_user.images.new
      i.image = params[:image]
      i.save!
      redirect_to user_path(current_user)
    end
    @image = Image.last && Image.last.image.url
    @images = current_user.images.paginate(page: params[:page], :per_page => 6)
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
