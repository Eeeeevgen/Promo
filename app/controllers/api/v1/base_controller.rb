require 'pp'

class Api::V1::BaseController < ApplicationController
  include Pundit

  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :permission_denied
  before_action :destroy_session
  before_action :authenticate

  def destroy_session
    request.session_options[:skip] = true
  end

  def not_found
    render json: {error: 'Not found', status: 404}
  end

  def permission_denied
    head  :unauthorized
    return false
  end

  def current_user
    @user
  end

  private
    def authenticate
      authenticate_with_http_token do |token, options|
        @user = User.find_by(token: token)
      end
    end
end