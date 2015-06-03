class LogsController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    place = Place.find_by(id: params[:place_id])
      time_param = DateTime.iso8601(params[:from_time])
      @new_activity = Log.activity(place.keys.pluck(:id),place.id).where(["created_at > ?", time_param]).order(created_at: :asc)
      render json: @new_activity
  end

  private

  def notification_params
    params.permit(:user_id,:key_id,:message)
  end

end