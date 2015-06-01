require 'securerandom'

class ClientKey < ActiveRecord::Base
  belongs_to :client
  belongs_to :key
  before_save :set_hashify

  def time_until(time_stamp)
    time_hash = {
    2419201 => "a few months from now",
    2419200 => "less than a month",
    1209600 => "about a couple of weeks",
    604800 => "about a week",
    345600 => "a few days",
    86400 => "less than a day",
    14400 => "less than a few hours",
    7200 => "less than 2 hours",
    5400 => "less than an hour and a half",
    3600 => "less than an hour",
    2700 => "less than 45 minutes",
    1800 => "less than 30 minutes",
    1200 => "less than 20 minutes",
    900 => "less than 15 minutes",
    600 => "less than 10 minutes",
    300 => "less than 5 minutes",
    120 => "less than 2 minutes",
    60 => "less than 1 minute",
    1 => "less than 1 second"}

    time_hash.each do |key,value|
      if (time_stamp - Time.now.utc) > key
        return value
      end
    end
  end

  def name
    key = Key.find_by(id: self.key_id)
    client = Client.find_by(id: self.client_id)
    time = time_until(key.start_date)
    if Time.now.utc > key.end_date
      "#{client.name} had access to #{key.place.nick_name}"
    elsif Time.now.utc > key.start_date && Time.now.utc < key.end_date
      "#{client.name} currently has access to #{key.place.nick_name}"
    else
    "#{client.name} will have access to #{key.place.nick_name} in #{time}"
    end
  end

  private

  def set_hashify
    self.hashify = SecureRandom.urlsafe_base64
  end

end
