class LogsController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @place = Place.find_by(id: params[:logs][:place_id])
    @new_activity = Log.activity(@place.keys.pluck(:id),@place.id).where(["id > ?", params[:logs][:act_id]]).order(created_at: :asc)
    render json: @new_activity
  end

end