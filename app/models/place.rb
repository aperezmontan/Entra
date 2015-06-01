class Place < ActiveRecord::Base

  has_one :user, foreign_key: :admin_id
  has_many :users
  has_many :keys

  def available_keys
    current_time = Time.now
    all_keys = keys.where([" start_date <= ? and end_date >= ? ",current_time,current_time])
    all_keys << ClientKey.find_by(client_id: 0).key
    all_keys
  end

end
