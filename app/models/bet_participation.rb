class BetParticipation < ActiveRecord::Base
  attr_accessible :bet_id, :status, :user_id
  validates :bet, :status, :user_id, presence: true
  validates :bet_id, :uniqueness => {:scope => :user_id}
  validates :status, :inclusion => {:in => ['pending', 'accepted', 'declined']}
  before_save :set_default_status_pending

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

  def set_default_status_pending
    if !self.status
      self.status = "pending"
    end
  end

end
