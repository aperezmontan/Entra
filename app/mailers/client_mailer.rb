class ClientMailer < ApplicationMailer
  default from: ENV['GMAIL_ACCOUNT']
 
  def buzzer_email(client)
    @client = client
    @url  = 'http://www.entra.com'
    mail(to: @client.email, subject: 'Welcome Entra')
  end
end
