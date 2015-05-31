class ClientKey < ActiveRecord::Base
  belongs_to :client
  belongs_to :key
end
