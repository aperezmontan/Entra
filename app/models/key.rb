class Key < ActiveRecord::Base
  belongs_to :place
  has_many :client_keys
  has_many :clients ,through: :client_keys

  def self.get_available_key keys
    keys.each do |key|
      client_key = key.client_keys.find_by(requested: true, used_at: nil)
      return client_key if client_key
    end
    nil
  end
end
