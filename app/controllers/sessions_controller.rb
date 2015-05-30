class SessionsController < ApplicationController

  def new
    redirect_to user_path (@current_user) if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if (user && user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:warning] = "Either username or password are incorrect."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end