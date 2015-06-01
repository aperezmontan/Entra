module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then return "alert alert-info"
    when :success then return "alert alert-success"
    when :error then return "alert alert-danger"
    when :alert then return "alert alert-warning"
    end
  end

  def time_until(time_stamp)
    time_hash = {
    2419201 => "a few months from now",
    2419200 => "less than a month",
    1209600 => "about a couple of weeks",
    604800 => "about a week",
    345600 => "about a few days",
    86400 => "less than a day",
    14400 => "less than a few hours",
    7200 => "less than 2 hours",
    5400 => "less than an hour and a half",
    3600 => "less than an hour",
    2700 => "less than 45 minutes",
    1800 => "less than 30 minutes",
    1200 => "less than 20 minutes",
    900 => "less than 15 minutes",
    600 => "less than 10 minutes",
    300 => "less than 5 minutes",
    120 => "less than 2 minutes",
    60 => "less than 1 minute",
    1 => "less than 1 second"}

    time_hash.each do |key,value|
      if (time_stamp - Time.now) < key
        return value
      end
    end

  end

end
