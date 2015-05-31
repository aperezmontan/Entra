class PlacesController < ApplicationController
  before_action :require_login, only: [:new, :create]


  def show

  end

  def new
    @place = Place.new
  end

  def create
    new_place = Place.new(get_params)
    new_place.user_id  = current_user.id
    new_place.admin_id = current_user.id
    if new_place.save
      flash[:success] = "#{new_place.nick_name} was saved"
      redirect_to user_path(current_user)
    else
      flash[:error] = "This place could not be saved"
      redirect_to :back #ask about changing this
    end
  end

  def update

  end

  def delete

  end

  def key
    place = Place.find_by(id: params[:id])
    if place 
      keys = place.available_keys
      client_key = Key.get_available_key(keys)
    end
    if client_key
      @response = { key: client_key.id, open: true}
    else 
      @response = { open: false}
    end
    render :json => @response
  end

  private

  def get_params
    params.require(:place).permit(:nick_name, :address)
  end

  def require_login
    unless logged_in?
      flash[:error] = "Please sign in."
      redirect_to login_path
    end
  end

end