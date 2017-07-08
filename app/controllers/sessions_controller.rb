require 'pp'

class SessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    if auth_hash = request.env['omniauth.auth']
      outcome = CreateSessionOmniauth.run!(auth_hash: auth_hash)
      # redirect_to edit_user_path(current_user)
    else
      outcome = CreateSessionCommon.run!(params.fetch(:user_session, {}))
    end

    flash[outcome[:status]] = outcome[:message]
    if outcome[:status] == :success
      redirect_to root_path
    else
      @user_session = UserSession.new()
      render :new
    end
  end

  def failure
    flash[:dnager] = "Sorry, but you didn't allow access to our app!"
    redirect_to login_path
  end

  def destroy
    if current_user_session
      current_user_session.destroy
      flash[:success] = "Goodbye!"
    end

    redirect_to root_path
  end
end
