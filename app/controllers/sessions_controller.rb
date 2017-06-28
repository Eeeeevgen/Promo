class SessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash # auth through social networks
      if current_user_session
        # Means our user is signed in. Add the authorization to the user
        current_user.add_provider(auth_hash)
        flash[:notice] = "You can now login using #{auth_hash["provider"]} too!"
      else
        # Log him in or sign him up
        auth = Authorization.find_or_create(auth_hash)

        # Create the session
        session[:user_id] = auth.user.id
        @user = User.find_by_email(auth.user.email)
        # puts_marked(@user)
        ses = UserSession.create(@user, true)
        # puts_marked(ses)

        # render :plain => "Welcome #{auth.user.name}!"
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
    session[:user_id] = nil
    if current_user_session
      current_user_session.destroy
      flash[:success] = "Goodbye!"
    end

    redirect_to root_path
  end

  private

    def user_session_params
      params.require(:user_session).permit(:email, :password, :remember_me, :test)
    end
end
