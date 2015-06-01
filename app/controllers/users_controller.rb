class UsersController < ApplicationController
  before_filter :require_login, except: [:new, :create,:keys,:set_status]
  before_action :set_user
  # before_action: time_till, only:[:show]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      flash[:warning] = "Couldn't create a user"
      render :new
    end
  end

  def edit

  end

  def update
    @user.update_attributes(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def delete

  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password)
  end

end
