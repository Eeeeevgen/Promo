require 'pp'

class SessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    puts
    puts
    pp auth_hash
    puts
    puts
    if auth_hash # auth through social networks
      if current_user_session
        current_user.add_provider(auth_hash)
        flash[:info] = "You can now login using #{auth_hash["provider"]}"
        redirect_to edit_user_path(current_user)
      else
        auth = Authorization.find_or_create(auth_hash)
        @user = User.find_by(email: auth.user.email)
        UserSession.create(@user, true)

        redirect_to root_path
      end
    else # auth through login/pass
      @user_session = UserSession.new(user_session_params)
      if @user_session.save
        flash[:success] = "Welcome back!"
        redirect_to root_path
      else
        flash[:danger] = "Wrong email or password!"
        render :new
        # redirect_to sign_in_path
      end
    end
  end

  def failure
    render :plain => "Sorry, but you didn't allow access to our app!"
  end

  def destroy
    if current_user_session
      current_user_session.destroy
      flash[:success] = "Goodbye!"
    end

    redirect_to root_path
  end

  private

    def user_session_params
      params.require(:user_session).permit(:email, :password, :remember_me)
    end
end
