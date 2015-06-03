class User < ActiveRecord::Base
  has_many :guests
  belongs_to :default_place, class_name: 'Place'
  has_many :places, foreign_key: :admin_id
  has_many :keys, through: :places
  has_many :notifications
  has_many :logs, as: :loggable
  has_secure_password
end
