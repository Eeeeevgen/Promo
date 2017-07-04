class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user_session, :current_user, :username, :avatar_url, :avatar_thumb_url, :like_button_style

  def puts_marked(input)
    puts 1111111111
    puts input
    puts 1111111111
  end

  private

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def username(id)
      user = User.find(id)
      if user
        user.name
      else
        "none"
      end
    end

    def avatar_url(id)
      user = User.find(id)
      user.avatar.blank? ? "default_avatar.png" : user.avatar
    end

    def avatar_thumb_url(id)
      user = User.find(id)
      user.avatar.blank? ? "default_avatar.png" : user.avatar.thumb
    end

    def like_button_style(image)
      if !current_user || image.user.id == current_user.id
        return "pointer-events: none;"
      end
      if image.likes.find_by(user_id: current_user.id)
        return "opacity: 0.5;"
      end
    end
end

