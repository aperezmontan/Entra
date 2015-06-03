class PlacesController < ApplicationController
  before_action :require_login, only: [:new, :create, :update,:set_default_place]
  before_action :get_place, only: [:show, :update, :delete, :key,:set_default_place]
  before_action :get_user, only: [:show, :create]

  def index
    @places = Place.where(admin_id: current_user.id)
  end

  def show
    unless @place
      redirect_to new_place_path
    end
    @is_default = current_user.default_place == @place
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
      flash[:success] = "#{@place.nickname} was saved"
      if params[:default]
        set_default_place
      else
        redirect_to place_path(@place)
      end
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

  def set_default_place    
    current_user.default_place = params[:action] == 'remove-default'? nil : @place 
    saved = current_user.save
    if saved
      flash[:success] = "#{@place.nickname} is your default place."
      redirect_url = place_path(@place) 
    else
      flash[:error] = "Couldn't set #{@place.nickname} as your default."
      redirect_url = :back
    end
    if request.xhr?
      render json: {updated: saved}
    else
      redirect_to redirect_url
    end
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