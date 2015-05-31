class PlacesController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def show

  end

  def create

  end

  def update

  end

  def delete

  end

  def keys
    place = Place.find_by(id: params[:id])
    
    @response = { key: '12345', open: false}
    render :json => @response
  end

end