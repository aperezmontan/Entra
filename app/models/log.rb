include ActionView::Helpers::DateHelper

class Log < ActiveRecord::Base
  belongs_to :loggable

  def new_key_success_message(key)
   self.message = "SUCCESS ! You created a new key for #{key.guest.name} at #{key.place.nickname}"
  end

  def new_key_fail_message(key)
   self.message = "FAILURE :( You could not create a new key for #{key.guest.name} at #{key.place.nickname}"
  end

  def destroy_key_success_message(key)
   self.message = "SUCCESS ! You destroyed a key for #{key.guest.name} at #{key.place.nickname}"
  end

  def destroy_key_fail_message(key)
   self.message = "FAILURE :( You could not destroy a key for #{key.guest.name} at #{key.place.nickname}"
  end

  def new_place_success_message(place)
   self.message = "SUCCESS ! You created a new place called #{place.nickname}"
  end

  def new_place_fail_message(place)
   self.message = "FAILURE :( You could not create #{place.nickname}"
  end

  def destroy_place_success_message(place)
   self.message = "SUCCESS ! You destroyed #{place.nickname}"
  end

  def destroy_place_fail_message(place)
   self.message = "FAILURE :( You could not destroy #{place.nickname}"
  end

  def new_guest_success_message(guest)
   self.message = "SUCCESS ! You created a new guest called #{guest.name}"
  end

  def new_guest_fail_message(guest)
   self.message = "FAILURE :( You could not create #{guest.name}"
  end

  def destroy_guest_success_message(guest)
   self.message = "SUCCESS ! You destroyed #{guest.name}"
  end

  def destroy_guest_fail_message(guest)
   self.message = "FAILURE :( You could not destroy #{guest.name}"
  end

  def notification_success_message(notification)
   self.message = "SUCCESS ! #{guest.name} send you a notification"
  end

  def notification_failure_message(notification)
   self.message = "FAILURE :( #{guest.name} send you a notification"
  end

  def requested_open_successfully_message(key) #when someone makes a request with a valid key
    self.message = "SUCCESS ! #{key.guest.name} requested to open -> #{key.place.nickname}"
  end

  def requested_open_unsuccessfully_message(key) #when someone makes a request with an invalid key
   self.message = "FAILURE :( #{key.guest.name} unsuccessfully requested to open -> #{key.place.nickname}"
  end

  def opened_successfully_message(key) #when the door opens successfully
    self.message = "SUCCESS ! #{key.place.nickname} opened by -> #{key.guest.name}"
  end

  def opened_unsuccessfully_message(key) #when door fails to open
   self.message = "FAILURE :( #{key.place.nickname} could not be opened by -> #{key.guest.name}"
  end

  def closed_successfully_message(key) #when the door closes successfully
    self.message = "SUCCESS ! #{key.place.nickname} opened by -> #{key.guest.name}"
  end

  def closed_unsuccessfully_message(key) #when door fails to close
   self.message = "FAILURE :( #{key.place.nickname} could not be opened by -> #{key.guest.name}"
  end

  ###################THIS WILL BE FOR ADMIN USE################################

  def admin_open_request_success(place) #when the admin user makes a request successfully
    self.message = "SUCCESS ! You requested to open -> #{place.nickname}"
  end

  def admin_open_request_fail(place) #when the admin user makes a request unsuccessfully
   self.message = "FAILURE :( You unsuccessfully requested to open -> #{place.nickname}"
  end

  def opened_successfully_message(place) #when the door for an admin user opens successfully
    self.message = "SUCCESS ! #{place.nickname} opened for -> You"
  end

  def closed_successfully_message(place) #when the door for an admin user closes successfully
    self.message = "SUCCESS ! #{place.nickname} closed for -> You"
  end

  ####################################NEED TO FIGURE OUT HOW TO DO THESE.  TIMER?#################

  def opened_unsuccessfully_message(place) #when the door for an admin user fails to open
   self.message = "FAILURE :( #{place.nickname} could not be opened for -> You"
  end

  def closed_unsuccessfully_message(place) #when the door for an admin user fails to close
   self.message = "FAILURE :( #{place.nickname} could not be closed for -> You"
  end

  ##############################################

  def time
    distance_of_time_in_words(self.created_at, Time.now)
  end

end