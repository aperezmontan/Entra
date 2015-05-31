class ClientKeysController < ApplicationController

  def update
  end

  

  def set_status
    render :json => params
  end
end