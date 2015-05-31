class TwilioController < ApplicationController
  before_action :twilio_authentication, only: [:send_text_message]

  def new
  end

  def send_text_message
    number_to_send_to = params[:user_phone]
    @twilio = Twilio::REST::Client.new @twilio_sid, @twilio_token
    @twilio.account.sms.messages.create(
      from: "+1#{@twilio_phone_number}",
      to: number_to_send_to,
      body: "This is an message. It gets sent to #{number_to_send_to}"
    )
  end


  private
  def twilio_authentication
    @twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    @twilio_token = ENV['TWILIO_AUTH_TOKEN']
    @twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']
  end
end