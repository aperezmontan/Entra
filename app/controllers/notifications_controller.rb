class NotificationsController < ApplicationController

  def create
    notification = Notification.new(notification_params)
    message = {notification_status: "success"}
    unless notification.save
      message = {notification_status: "not_success"}
    end
    key = Key.find_by(id: params[:key_id])
    res = GuestMailer.notification_email(key,current_user,params[:message],base_url).deliver_now
    flash[:success] = "Email send successfully"
    redirect_to :back
  end

  private

  def notification_params
    params.permit(:user_id,:key_id,:message)
  end

end