class ClientKeysController < ApplicationController

  def new
    @client_key = ClientKey.new
    @user_keys = Key.where(" place_id == ? ", current_user.places.ids)
  end

  def create
    new_client_key = ClientKey.new(get_params)
    if new_client_key.save
      flash[:success] = "New access created"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Access could not be created :("
      redirect_to user_path(current_user)
    end

  end

  def update
    clientKey = ClientKey.find_by(id: params[:id])
    clientKey.update_attributes(client_key_params)
    if !clientKey.save
      flash[:warning] = "Couldn't open."
    end
    redirect_to :back
  end

  def used_at
    clientKey = ClientKey.find_by(id: params[:client_key_id])
    unless clientKey
      clientKey = ClientKey.find_by(client_id: params[:client_key_id])
    end
    clientKey.used_at = Time.now if (params[:status] == 'opened')
    clientKey.requested = false if clientKey.client_id == 0
    clientKey.save
    render :json => params
  end

  def request_open_show
    @clientKey = ClientKey.find_by(hashify: params[:hash])
  end

  private

  def client_key_params
    params.require(:client_key).permit(:requested,:used_at,:client_id,:key_id)
  end

  def get_params
    params.require(:client_key).permit(:client_id, :key_id)
  end

end