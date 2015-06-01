class ClientKeysController < ApplicationController


  def update
    @client_key = ClientKey.find_by(client_id: params[:id])
    @client_key.update_attributes(requested: true)
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

end