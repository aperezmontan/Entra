class ClientMailer < ApplicationMailer
  default from: ENV['GMAIL_ACCOUNT']
 
  def buzzer_email(clientKey,current_user)
    @clientKey = clientKey
    @url  = "http://10.0.2.185:3000/request_open_show/#{@clientKey.hashify}"
    mail(to: @clientKey.client.email, subject: "Access granted by #{current_user.first_name}")
  end
end
