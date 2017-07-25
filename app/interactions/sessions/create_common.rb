module Sessions
  class CreateCommon < ActiveInteraction::Base
    string :email
    string :password
    boolean :remember_me

    def execute
      @user_session = UserSession.new(inputs)
      if @user_session.save
        message = 'Welcome back!'
        status = :success
      else
        message = 'Wrong email or password!'
        status = :danger
      end
      { message: message, status: status }
    end
  end
end
