require 'pp'

module Sessions
  class CreateOmniauth < ActiveInteraction::Base
    hash :auth_hash,
         strip: false
    object :current_user,
           class: User,
           default: nil

    def execute
      pp auth_hash
      if current_user
        auth = Authorization.find_by(provider: auth_hash['provider'], uid: auth_hash['uid'])
        if !auth
          current_user.add_provider(auth_hash)
          message = "You can now login using #{auth_hash['provider']}"
          status = :success
        else
          message = 'This account has been already used'
          status = :warning
        end
      else
        auth = Authorization.find_or_create(auth_hash)
        @user = User.find_by(email: auth.user.email)
        UserSession.create(@user, true)
        message = "Welcome, #{auth.user.name}!"
        status = :success
      end
      { message: message, status: status }
    end
  end
end
