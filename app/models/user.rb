class User < ActiveRecord::Base
  has_many :clients
  has_many :places
  has_many :notifications
  has_secure_password
end
