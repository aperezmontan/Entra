require 'securerandom'

class ClientKey < ActiveRecord::Base
  belongs_to :client
  belongs_to :key
  before_save :set_hashify

  private

  def set_hashify
    self.hashify = SecureRandom.urlsafe_base64
  end

end
