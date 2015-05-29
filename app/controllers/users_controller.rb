class UsersController < ApplicationController
  before_action :require_login, except: [:show, :new, :create]

  def show
    if logged_in?
      @current_user
    else
      redirect_to new_user_path
    end
  end

  def new
    @user = User.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def delete

  end

  private

  def require_login
    if logged_in?
      return true
    else
      flash[:error] = "Please sign in."
      redirect_to :back
    end
  end

end
