class LogsController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @all_logs = Log.where(loggable_type: "User", loggable_id: current_user.id).order(created_at: :desc)
  end

  private

  def notification_params
    params.permit(:user_id,:key_id,:message)
  end

  def

end