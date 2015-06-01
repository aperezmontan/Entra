class ClientKeysController < ApplicationController


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
    if (params[:status] == 'opened')
      clientKey.used_at = Time.now 
      clientKey.save
    end
    render :json => params
  end

  def request_open_show
    @clientKey = ClientKey.find_by(hashify: params[:hash])
  end

  private 

  def client_key_params
    params.require(:client_key).permit(:requested,:used_at,:client_id,:key_id)
  end
end