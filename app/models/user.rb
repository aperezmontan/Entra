class User < ActiveRecord::Base
  has_many :clients
  has_many :places
  has_secure_password

  def reservations
    clientids = []
    self.clients.each do |client|
      clientids << client.id
    end

    ClientKey.where( "client_id = ?", clientids)
  end

end
