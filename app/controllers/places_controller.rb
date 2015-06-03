class PlacesController < ApplicationController
  before_action :get_place, only: [:show, :update, :delete, :key,:set_default_place]
  before_action :require_login, except: [:key,:update_master]
  before_action :get_user, only: [:show, :create]

  def index
    @places = Place.where(admin_id: current_user.id)
  end

  def show
    unless @place
      redirect_to new_place_path
    end
    @is_default = current_user.default_place == @place
    @activity = Log.activity(@place.keys.pluck(:id),@place.id).order(created_at: :asc)
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
    new_log = Log.new(loggable_type: "Place", loggable_id: @place.id)
    saved = @place.save
    if saved && @place.master_unlock
      new_log.admin_open_request_success(@place)
    elsif saved && (@place.master_unlock == false)
      new_log.admin_close_request_success(@place)
    elsif !saved && @place.master_unlock
      new_log.admin_open_request_fail(@place)
    else
      new_log.admin_close_request_fail(@place)
    end
    new_log.save
    render json: {updated: saved}
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
    new_log = place.logs.build()
    new_activity = place.logs.build()
    if params[:status] == "opened"
      new_log.opened_successfully_message(place)
    else
      new_log.closed_successfully_message(place)
      new_activity.admin_access(place)
      new_activity.save
    end
    new_log.save
    render :json => params
  end

  def set_default_place
    remove_default = params[:place][:action] == 'remove-default' if (params[:place] && params[:place][:action])
    current_user.default_place = remove_default ? nil : @place
    saved = current_user.save
    if saved
      if remove_default
        flash[:notice] = "#{@place.nickname} is no longer your default."
      else
        flash[:success] = "#{@place.nickname} is your default place."
      end
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