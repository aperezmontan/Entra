class Place < ActiveRecord::Base

  belongs_to :admin, class_name: 'User'
  has_many :keys
  has_many :logs, as: :loggable

  validates :nickname, :address, :admin_id, presence: true

  def available_key
    current_time = Time.new.getutc
    keys.where([" (start_date <= ? and end_date >= ? and used_at is NULL and requested = ?) or ( requested = ? and unlimited_access = ?) ",current_time,current_time,true,true,true]).take
  end

end
