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

end
