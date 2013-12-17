class LoserEntry < ActiveRecord::Base
  attr_accessible :bet_id, :user_id

  belongs_to(
  :bet,
  class_name: "Bet",
  foreign_key: :bet_id,
  primary_key: :id
  )

  belongs_to(
  :loser,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )

end
