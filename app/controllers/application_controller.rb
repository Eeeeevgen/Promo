class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  helper_method :current_user_session, :current_user, :username, :avatar_thumb_url, :like_button_style

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session &. user
    # @current_user = current_user_session && current_user_session.user
  end

  def username(id)
    User.find(id).name
  end

  def avatar_thumb_url(id)
    user = User.find(id)
    user.avatar.thumb.url
  end

  def like_button_style(image)
    if !current_user || image.user.id == current_user.id
      return 'pointer-events: none; opacity: 0.5;'
    end
    if image.likes.find_by(user_id: current_user.id)
      'opacity: 1;'
    else
      'opacity: 0.5;'
    end
  end

  def not_found
    # render json: {error: 'Not found', status: 404}
    redirect_to root_path
  end

  def permission_denied
    flash[:danger] = 'Authorization error'
    redirect_to request.referrer || root_path
  end

  def set_admin_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # def default_url_options
  #   if controller_path.split('/').first == 'admin'
  #     { locale: I18n.locale }
  #   else
  #     {}
  #   end
  # end
end
