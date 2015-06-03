class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :require_login, :time_until, :base_url
  after_filter :flash_to_headers

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def base_url
    "#{request.protocol}#{request.host_with_port}"
  end

  def flash_to_headers
     return unless request.xhr?
     response.headers['X-Message'] = flash_message
     response.headers["X-Message-Type"] = flash_type.to_s

     flash.discard # don't want the flash to appear when you reload page
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "Please sign in."
      redirect_to root_path
    end
  end

  def flash_message
     [:error, :warning, :notice, nil].each do |type|
       return "" if type.nil?
       return flash[type] unless flash[type].blank?
     end
  end

  def flash_type
     [:error, :warning, :notice, nil].each do |type|
         return "" if type.nil?
         return type unless flash[type].blank?
     end
  end

end
