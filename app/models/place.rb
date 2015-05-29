class Place < ActiveRecord::Base
  belongs_to :user, foreign_key: :admin_id
end
