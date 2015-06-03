## DONT DELETE ANONYMOUS GUEST
anonymous_guest = Guest.create(name:'Anonymous Guest', phone:'none', user_id:0, email:'entra.app+anonymous@gmail.com')
## DONT DELETE ANONYMOUS GUEST











ari = User.new(first_name: "Ari", last_name: "Perez", email: "ari@me.com", password: "12345")

ari.save

place = Place.create(address:'Juan Dolio', nickname:'Beach House',admin_id:ari.id)
guest = Guest.create(name:'Luis', phone:'8098541988',user_id:ari.id,email:'echenique11@hotmail.com')
key = Key.create(place_id:place.id,start_date:Time.now,end_date:Date.parse('11-11-2020'),guest_id: guest.id)

ari.default_place = place
ari.save