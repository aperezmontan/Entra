class NotificationsController < ApplicationController
  
  def create
    notification = Notification.new(notification_params)
    message = {notification_status: "success"}
    unless notification.save
      message = {notification_status: "not_success"}
    end
    render :json => message
  end

  private

  def notification_params
    params.permit(:user_id,:key_id,:message)
  end

end