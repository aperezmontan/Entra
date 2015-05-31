class Key < ActiveRecord::Base
  belongs_to :place
  has_many :clients
end
