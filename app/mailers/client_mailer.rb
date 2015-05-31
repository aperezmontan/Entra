class ClientMailer < ApplicationMailer
  default from: ENV['GMAIL_ACCOUNT']
 
  def buzzer_email(client,hash,current_user)
    @client = client
    @url  = "http://10.0.2.185:3000/request_open_show/#{hash}"
    mail(to: @client.email, subject: "Access granted by #{current_user.first_name}")
  end
end
