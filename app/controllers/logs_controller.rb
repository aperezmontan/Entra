class LogsController < ApplicationController

  def index
    all_logs = Log.where()
  end

  private

  def notification_params
    params.permit(:user_id,:key_id,:message)
  end

end