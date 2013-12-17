class Comment < ActiveRecord::Base
  attr_accessible :user_id, :bet_id, :text

  belongs_to(
  :author,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )

  belongs_to(
  :bet,
  class_name: "Bet",
  foreign_key: :bet_id,
  primary_key: :id
  )

  def time_since_last_update
    age = Time.now()-self.updated_at

    if age > 86400
      return (age / 86400).floor.to_s + " days ago"
    elsif age > 3600
      return (age / 3600).floor.to_s + " hours ago"
    else age
      return (age / 60).floor.to_s + " minutes ago"
    end
  end

end
