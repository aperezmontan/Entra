# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ari = User.new(first_name: "Ari", last_name: "Perez", email: "ari@me.com", password_digest: "12345")

ari.save

place = Place.create(address:'Juan Dolio', nick_name:'Beach House',admin_id:ari.id,user_id:ari.id)
client = Client.create(name:'Luis', phone:'8098541988',user_id:ari.id,email:'echenique11@hotmail.com')
key = Key.create(place_id:place.id,start_date:Time.now,end_date:Time.now)
ClientKey.create(client_id:client.id,key_id:key.id)