module Sessions
  class CreateOmniauth < Sessions::BaseInteraction
    hash :auth_hash,
         strip: false

    def execute
      if current_user_session
        current_user.add_provider(auth_hash)
        message = "You can now login using #{auth_hash["provider"]}"
        status = :success
      else
        auth = Authorization.find_or_create(auth_hash)
        @user = User.find_by(email: auth.user.email)
        UserSession.create(@user, true)
        message = "Welcome, #{auth.user.name}!"
        status = :success
      end
      {message: message, status: status}
    end
  end
end