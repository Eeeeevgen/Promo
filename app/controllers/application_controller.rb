class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  helper_method :current_user_session, :current_user

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session.try(:user)
  end

  def not_found
    redirect_to root_path
  end

  def permission_denied
    flash[:danger] = 'Authorization error'
    redirect_to request.referrer || root_path
  end

  def set_admin_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    if controller_path.split('/').first == 'admin'
      { locale: I18n.locale }
    else
      {}
    end
  end
end
