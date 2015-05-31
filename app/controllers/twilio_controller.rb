class TwilioController < ApplicationController
  before_action :twilio_authentication, :get_twilio_account

  def send_text_message
    number_to_send_to = params[:user_phone]
    @twilio.account.messages.create(
      from: "+1#{@twilio_phone_number}",
      to: number_to_send_to,
      body: "Hi <ENTER USER> from #{number_to_send_to}. To unlock your door. Please reply to this message."
    )
  end

  def receive_text_message
    print "*" * 50; puts
    puts params
  end

  private
  def twilio_authentication
    @twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    @twilio_token = ENV['TWILIO_AUTH_TOKEN']
    @twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']
  end

  def get_twilio_account
    @twilio = Twilio::REST::Client.new @twilio_sid, @twilio_token
  end
end