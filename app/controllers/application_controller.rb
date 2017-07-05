class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  helper_method :current_user_session, :current_user, :current_user_admin?, :username, :avatar_url, :avatar_thumb_url, :like_button_style

  def puts_marked(input)
    puts 1111111111
    puts input
    puts 1111111111
  end

  def not_found
    # render json: {error: 'Not found', status: 404}
    redirect_to root_path
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

    def require_admin
      # puts 11111111111111111
      # puts current_user
      # puts current_user.admin
      # puts 11111111111111111
      if !(current_user && current_user.admin)
        flash[:danger] = 'Access denied!'
        redirect_to root_path
      end
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
        return "opacity: 1;"
      else
        return "opacity: 0.5;"
      end
    end
end

