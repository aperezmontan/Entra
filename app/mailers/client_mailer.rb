class ClientMailer < ApplicationMailer
  default from: ENV['GMAIL_ACCOUNT']
 
  def buzzer_email(base_url,clientKey,current_user)
    @clientKey = clientKey
    @url  = "#{base_url}/request_open_show/#{@clientKey.hashify}"
    mail(to: @clientKey.client.email, subject: "Access granted by #{current_user.first_name}")
  end
end
