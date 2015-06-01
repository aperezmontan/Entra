require 'securerandom'

class Key < ActiveRecord::Base
  belongs_to :place
  belongs_to :guest
  before_create :set_secret_url

  def self.get_available_key keys
    keys.each do |key|
      client_key = key.client_keys.find_by(requested: true, used_at: nil)
      master_key = key.client_keys.find_by(requested: true, unlimited_access: true)
      return client_key if client_key
      return master_key if master_key
    end
    nil
  end

  def cleaner_time(start_or_end)
    self.send(start_or_end).strftime("%I:%M %p %a %b %e, %Y")
  end

  def place_and_time
    "#{self.place.nickname} between #{self.start_date} and #{self.end_date}"
  end

  private

  def set_secret_url
    self.secret_url = SecureRandom.urlsafe_base64
  end

end
