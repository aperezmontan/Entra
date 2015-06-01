# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ari = User.new(first_name: "Ari", last_name: "Perez", email: "ari@me.com", password: "12345")

ari.save

place = Place.create(address:'Juan Dolio', nickname:'Beach House',admin_id:ari.id)
guest = Guest.create(name:'Luis', phone:'8098541988',user_id:ari.id,email:'echenique11@hotmail.com')
key = Key.create(place_id:place.id,start_date:Time.now,end_date:Date.parse('11-11-2020'),guest_id: guest.id)

ari.deafult_place = place
ari.save