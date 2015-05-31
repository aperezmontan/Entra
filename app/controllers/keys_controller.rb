class KeysController < ApplicationController
  before_action :require_login, only: [:show, :new, :edit, :delete]

  def show

  end

  def new
    @key = Key.new
  end

  def create
    new_key = Key.new(get_params)
    if new_key.save
      flash[:success] = "New key created"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Key could not be created :("
      redirect_to user_path(current_user)
    end
  end

  def edit

  end

  def update

  end

  def delete

  end

  private

  def get_params
    params.require(:key).permit(:place_id, :start_date, :end_date)
  end

end