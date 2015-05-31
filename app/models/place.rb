class Place < ActiveRecord::Base

  has_one :user, foreign_key: :admin_id
  has_many :users

  def available_keys
    keys.where([" start_date >= ? and end_date <= ? ","keys.start_date","keys.end_date"])
  end

end
