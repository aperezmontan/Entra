class User < ActiveRecord::Base
  has_many :clients
  has_and_belongs_to_many :places

end
