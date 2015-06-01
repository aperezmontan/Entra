class Place < ActiveRecord::Base

  belongs_to :admin, class_name: 'User'
  has_many :keys

  def available_keys
    current_time = Time.now
    all_keys = keys.where([" start_date <= ? and end_date >= ? ",current_time,current_time])
    all_keys << ClientKey.find_by(client_id: 0).key
    all_keys
  end

end
