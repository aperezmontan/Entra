class User < ActiveRecord::Base
  has_many :guests
  has_many :places
  has_many :keys, through: :places
  has_many :notifications
  has_secure_password

end
