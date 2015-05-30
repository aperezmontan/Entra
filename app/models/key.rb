class Key < ActiveRecord::Base
  belongs_to :place
  has_and_belongs_to_many :clients
end
