class TwillioController < ApplicationController
  before_action :twillio_authentication

  def new
  end

  def send_text_message
    @twillio = Twilio::REST::Client.new @twilio_sid, @twilio_token
    @twilio_client.account.sms.messages.create(
      from: "+1#{twilio_phone_number}",
      to: params[:user].phone_number
      body: "This is an message. It gets sent to #{number_to_send_to}"
    )
  end


  private
  def twillio_authentication
    @twillio_sid = ENV['TWILLIO_ACCOUNT_SID']
    @twillio_token = ENV['TWILLIO_AUTH_TOKEN']
    @twillio_phone_number = ENV['TWILLO_PHONE_NUMBER']
  end
end