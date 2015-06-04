class LogsController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    puts "params #{params}"
    puts params[:place_id]
    puts params["place_id"]
    @place = Place.find_by(id: params[:logs][:place_id])
    puts "place #{@place}"
    # binding.pry
    @new_activity = Log.activity(@place.keys.pluck(:id),@place.id).where(["id > ?", params[:logs][:act_id]]).order(created_at: :asc)
    # puts @place
    # @new_activity = @place.keys
    # puts @new_activity
    render json: @new_activity
  end

  private

  def notification_params
    params.permit(:user_id,:key_id,:message)
  end

end