class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :require_login, :time_until, :base_url

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def base_url
    "#{request.protocol}#{request.host_with_port}"
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "Please sign in."
      redirect_to root_path
    end
  end

end
