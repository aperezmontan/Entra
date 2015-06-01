class User < ActiveRecord::Base
  has_many :guests
  has_one :default_place, class_name: 'Place'
  has_many :places, foreign_key: :admin_id
  has_many :keys, through: :places
  has_many :notifications
  has_secure_password

end
