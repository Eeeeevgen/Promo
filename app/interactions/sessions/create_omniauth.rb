module Sessions
  class CreateOmniauth < ActiveInteraction::Base
    hash :auth_hash,
         strip: false
    object :current_user,
           class: User,
           default: nil

    def execute
      if current_user
        add_auth_to_user
      else
        find_or_create_user
      end
    end

    def add_auth_to_user
      auth = Authorization.find_by(provider: auth_hash['provider'], uid: auth_hash['uid'])
      if !auth
        Authorization.create user: current_user, provider: auth_hash['provider'], uid: auth_hash['uid']
        { message: "You can now login using #{auth_hash['provider']}", status: :success }
      else
        { message: 'This account has been already used', status: :warning }
      end
    end

    def find_or_create_user
      auth = find_or_create_auth
      @user = User.find_by(email: auth.user.email)
      UserSession.create(@user, true)
      { message: "Welcome, #{auth.user.name}!", status: :success }
    end

    def find_or_create_auth
      auth = Authorization.find_by(provider: auth_hash['provider'], uid: auth_hash['uid'])
      unless auth
        user = User.find_by(email: auth_hash['info']['email'])
        unless user
          user = User.create(name: auth_hash['info']['name'],
                             email: auth_hash['info']['email'],
                             password: auth_hash['credentials']['token'],
                             password_confirmation: auth_hash['credentials']['token'],
                             remote_avatar_url: auth_hash['info']['image'],
                             token: SecureRandom.urlsafe_base64)
        end
        auth = Authorization.create(user: user, provider: auth_hash['provider'], uid: auth_hash['uid'])
      end
      auth
    end
  end
end
