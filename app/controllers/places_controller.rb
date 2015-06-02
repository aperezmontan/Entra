class PlacesController < ApplicationController
  before_action :require_login, only: [:new, :create, :update]
  before_action :get_place, only: [:show, :update, :delete, :key]
  before_action :get_user, only: [:show, :create]

  def show
  end

  def new
    @place = Place.new
    respond_to do |format|
      if request.xhr?
        format.html { render :new, layout: false}
      else
        format.html { render :new }
      end
    end
  end

  def create
    @place = Place.new(get_params)
    @place.admin_id = @user.id
    if @place.save
      flash[:success] = "#{new_place.nickname} was saved"
      redirect_to place_path(@place)
    else
      flash[:error] = "This place could not be saved"
      redirect_to :back #ask about changing this
    end
  end

  def update
    @place.assign_attributes(master_unlock: params.has_key?(:o))
    render json: {updated: @place.save}
  end

  def delete

  end

  def key
    place = Place.find_by(id: params[:id])
    if place.master_unlock
      @response = { master: true, open: true}
    elsif place.available_key
      key = place.available_key
      @response = { key: key.id, open: true}
    else
      @response = { open: false }
    end
    render :json => @response
  end

  def update_master
    place = Place.find_by(id: params[:id])
    place.master_unlock = false
    place.save
    render :json => params
  end

  private

  def get_params
    params.require(:place).permit(:nickname, :address)
  end

  def get_place
    @place = Place.find_by(id: params[:id])
  end

  def get_user
    @user = current_user
  end

end