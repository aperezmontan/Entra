require 'securerandom'

class ClientKey < ActiveRecord::Base
  belongs_to :client
  belongs_to :key
  before_create :set_hashify

  def is_available?
    current_time = Time.now.in_time_zone("Eastern Time (US & Canada)")
    key.start_date <= current_time && key.end_date >= current_time && !used_at
  end

  def get_start_date_string
    key.start_date.strftime("%Y/%m/%d %H:%M:%S")
  end
  
  private

  def set_hashify
    self.hashify = SecureRandom.urlsafe_base64
  end

end
