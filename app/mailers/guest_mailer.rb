class GuestMailer < ApplicationMailer
  default from: ENV['GMAIL_ACCOUNT']

  def buzzer_email(base_url,key,current_user)
    @key = key
    @url  = "#{base_url}/find_guests_key_by_url/#{@key.secret_url}"
    mail(to: @key.guest.email, subject: "Access granted by #{current_user.first_name}")
  end

  def notification_email(key,current_user,message,base_url)
    @message = message
    @key = key
    @link = base_url + "/keys/#{key.id}/edit"
    @user_name = current_user.first_name
    mail(to: current_user.email, subject: "Notification from #{@key.guest.name}")
  end

end
