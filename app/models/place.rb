class Place < ActiveRecord::Base

  belongs_to :admin, class_name: 'User'
  has_many :keys
  has_many :logs, through: :keys

  def available_key
    current_time = Time.new.getutc
    keys.where([" start_date <= ? and end_date >= ? and used_at is NULL and requested = ?",current_time,current_time,true]).take
  end

end
