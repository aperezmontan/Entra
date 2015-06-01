class GuestMailer < ApplicationMailer
  default from: ENV['GMAIL_ACCOUNT']

  def buzzer_email(base_url,key,current_user)
    @key = key
    @url  = "#{base_url}/request_open_show/#{@key.secret_url}"
    mail(to: @key.guest.email, subject: "Access granted by #{current_user.first_name}")
  end
end
