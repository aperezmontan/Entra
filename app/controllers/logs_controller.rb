class LogsController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    place = Place.find_by(id: params[:place_id])
    if request.xhr?
      if params[:from_time].include?('T')
        from_time = params[:from_time]
      else
        from_time = Time.at( params[:from_time].to_i/ 1000.0)
      end
      @new_activity = Log.activity(place.keys.pluck(:id),place.id).where(["created_at > ?", from_time]).order(created_at: :asc)
      render json: @new_activity
    end
  end

  private

  def notification_params
    params.permit(:user_id,:key_id,:message)
  end

end