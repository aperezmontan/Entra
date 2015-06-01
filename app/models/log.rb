class Log < ActiveRecord::Base
  belongs_to :key

  def new_key_message(key)
   message = "You created a new key for #{key.guest.name} at #{key.place.nickname} #{distance_of_time_in_words(created_at, Time.now)} ago"
  end

  def destroy_key_message(key)
   message = "You destroyed a key for #{key.guest.name} at #{key.place.nickname} #{distance_of_time_in_words(created_at, Time.now)} ago"
  end

  def key_tried_successfully_message(key)
   message = "SUCCESS ! #{key.guest.name} successfully used a key for #{key.place.nickname} #{distance_of_time_in_words(created_at, Time.now)} ago"
  end

  def key_tried_unsuccessfully_message(key)
   message = "FAILURE :( #{key.guest.name} unsuccessfully used a key for #{key.place.nickname} #{distance_of_time_in_words(created_at, Time.now)} ago"
  end

  def admin_use(place)
   message = "You used a key for #{place.nickname} #{distance_of_time_in_words(created_at, Time.now)} ago"
  end

end