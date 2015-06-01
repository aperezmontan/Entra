class SessionsController < ApplicationController
  before_action :get_default_place, only: [:new, :create]

  def new
    redirect_to place_path(@default) if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if (user && user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to place_path(@default)
    else
      flash[:warning] = "Either username or password are incorrect."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private
  def get_default_place
    @default = current_user.places.first # Should be default
  end
end