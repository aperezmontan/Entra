class Place < ActiveRecord::Base

  has_one :user, foreign_key: :admin_id
  has_many :users
  has_many :keys
  after_create :create_master_key

  def available_keys
    current_time = Time.now
    all_keys = keys.where([" start_date <= ? and end_date >= ? ",current_time,current_time])
    all_keys << ClientKey.find_by(client_id: 0).key
    all_keys
  end

  def create_master_key
    master_key = ClientKey.new(client_id: 0, unlimited_access: true)
    master_key.build_key(place_id: self.id, start_date: Time.now, end_date: Time.now)
    master_key.save
  end

end
