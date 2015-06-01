class Log < ActiveRecord::Base
  belongs_to :key

  def new_key_success_message(key)
   message = "SUCCESS ! You created a new key for #{key.guest.name} at #{key.place.nickname}"
  end

  def new_key_fail_message(key)
   message = "FAILURE :( You could not creat a new key for #{key.guest.name} at #{key.place.nickname}"
  end

  def destroy_key_success_message(key)
   message = "SUCCESS ! You destroyed a key for #{key.guest.name} at #{key.place.nickname}"
  end

  def destroy_key_fail_message(key)
   message = "FAILURE :( You could not destroy a key for #{key.guest.name} at #{key.place.nickname}"
  end

  def new_place_success_message(place)
   message = "SUCCESS ! You created a new place called #{place.nickname}"
  end

  def new_place_fail_message(place)
   message = "FAILURE :( You could not create #{place.nickname}"
  end

  def destroy_place_success_message(place)
   message = "SUCCESS ! You destroyed #{place.nickname}"
  end

  def destroy_place_fail_message(place)
   message = "FAILURE :( You could not destroy #{place.nickname}"
  end

  def new_guest_success_message(guest)
   message = "SUCCESS ! You created a new guest called #{guest.name}"
  end

  def new_guest_fail_message(guest)
   message = "FAILURE :( You could not create #{guest.name}"
  end

  def destroy_guest_success_message(guest)
   message = "SUCCESS ! You destroyed #{guest.name}"
  end

  def destroy_guest_fail_message(guest)
   message = "FAILURE :( You could not destroy #{guest.name}"
  end

  def notification_success_message(notification)
   message = "SUCCESS ! #{guest.name} send you a notification"
  end

  def notification_failure_message(notification)
   message = "FAILURE :( #{guest.name} send you a notification"
  end

  def requested_open_successfully_message(key)
   message = "SUCCESS ! #{key.guest.name} successfully requested to open #{key.place.nickname}"
  end

  def requested_open_unsuccessfully_message(key)
   message = "FAILURE :( #{key.guest.name} unsuccessfully requested to open #{key.place.nickname}"
  end

  def key_used_successfully_message(key)
   message = "SUCCESS ! #{key.guest.name} successfully used a key for #{key.place.nickname}"
  end

  def key_used_unsuccessfully_message(key)
   message = "FAILURE :( #{key.guest.name} tried unsuccessfully to use a key for #{key.place.nickname}"
  end

  def admin_use_success(place)
   message = "SUCCESS ! You used a key for #{place.nickname}"
  end

  def admin_use_fail(place)
   message = "FAILURE :( You used a key for #{place.nickname}"
  end

  def time
    distance_of_time_in_words(self.created_at, Time.now)
  end

end