class SessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash
      outcome = Sessions::CreateOmniauth.run!(auth_hash: auth_hash,
                                              current_user: current_user)
    else
      puts params
      outcome = Sessions::CreateCommon.run!(params[:user_session])
    end

    flash[outcome[:status]] = outcome[:message]
    if outcome[:status] == :success
      redirect_to root_path
    elsif outcome[:status] == :warning
      redirect_to edit_user_path(current_user)
    else
      @user_session = UserSession.new
      render :new
    end
  end

  def failure
    flash[:danger] = 'Sorry, but you didn\'t allow access to our app!'
    redirect_to login_path
  end

  def destroy
    if current_user_session
      current_user_session.destroy
      flash[:success] = 'Goodbye!'
    end

    redirect_to root_path
  end
end
