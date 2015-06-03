class SessionsController < ApplicationController

  def new
    if logged_in?
      default = current_user.default_place
      if default 
        redirect_to place_path(default)
      else
        redirect_to places_path
      end
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if (user && user.authenticate(params[:password]))
      session[:user_id] = user.id
      @default = current_user.default_place
      redirect_to place_path(@default)
    else
      flash[:error] = "Either username or password are incorrect."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end