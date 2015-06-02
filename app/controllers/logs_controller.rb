class LogsController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    if request.xhr?
      if params[:from_time].include?('T')
        from_time = params[:from_time]
      else
        from_time = Time.at( params[:from_time].to_i/ 1000.0)
      end
      new_logs = Log.where(["loggable_type = ? and loggable_id = ? and created_at > ?","Place",params[:place_id],from_time]).order(created_at: :asc)

      render json: new_logs
    end
  end

  private

  def notification_params
    params.permit(:user_id,:key_id,:message)
  end

end