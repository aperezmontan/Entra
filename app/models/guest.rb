class Guest < ActiveRecord::Base
  belongs_to :user
  has_many :keys
  has_many :logs, as: :loggable

end
