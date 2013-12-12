class BetParticipation < ActiveRecord::Base
  attr_accessible :bet_id, :status, :user_id
  validates :bet_id, :status, :user_id, presence: true
  validates :bet_id, :uniqueness => {:scope => :user_id}
  validates :status, :inclusion => {:in => ['Pending', 'Accepted', 'Denied']}
  
  belongs_to(
  :bet,
  class_name: "Bet",
  foreign_key: :bet_id,
  primary_key: :id
  )
  
  belongs_to(
  :participant,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )
  
end
