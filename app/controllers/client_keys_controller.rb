class ClientKeysController < ApplicationController

  def update
  end

  def used_at
    clientKey = ClientKey.find_by(id: params[:client_key_id])
    clientKey.used_at = Time.now if (params[:status] == 'opened')
    clientKey.save
    render :json => params
  end

  def request_open_show
    @clientKey = ClientKey.find_by(hashify: params[:hash])
  end
end