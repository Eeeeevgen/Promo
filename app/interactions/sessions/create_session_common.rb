require 'active_interaction'
require 'pp'

class CreateSessionCommon < ActiveInteraction::Base
  string :email
  string :password
  boolean :remember_me

  def execute
    flash = {}
    @user_session = UserSession.new(inputs)
    if @user_session.save
      message = "Welcome back!"
      status = :success
    else
      message = "Wrong email or password!"
      status = :danger
    end
    {message: message, status: status}
  end
end