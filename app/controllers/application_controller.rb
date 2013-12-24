class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Helpers
  include ActionController::Cookies

  before_filter :set_headers

  protected

  def current_user
    @current_user ||= if session[:user_id]
      User.find(session[:user_id])
    elsif cookies[:auth_token]
      token = UserToken.joins(:user).includes(:user).where('user_tokens.token = ? AND user_tokens.created_at >= ?', cookies[:auth_token], 14.days.ago).first
      token.touch
      session[:user_id] = token.user_id
      token.user
    else
      nil
    end
  rescue
    session.delete :user_id
    cookies.delete :auth_token
  end

  def require_login
    unless current_user
      redirect_to '/require_login.html'
    end
  end

  def set_headers
    headers['Access-Control-Allow-Headers'] = 'Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, Api-Version, Response-Time'
    headers['Access-Control-Allow-Methods'] = 'GET'
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Expose-Headers'] = 'Api-Version, Request-Id, Response-Time'
  end

end
