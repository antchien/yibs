class Bet < ActiveRecord::Base
  attr_accessible :private, :status, :terms, :user_id, :wager
  validates :status, :terms, :user_id, presence: true
  validates :status, :inclusion => {:in => ['Pending', 'In Play', 'Completed', 'Cancelled']}
  validates :private, :inclusion => {:in => [true, false]}
  
  belongs_to(
  :author,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id
  )
  
  has_many(
  :participations,
  class_name: "BetParticipation",
  foreign_key: :bet_id,
  primary_key: :id
  )
  
  has_many :participants, :through => :participations, source: :participant
  has_many :accepted_participants, :through => :participations, source: :participant, :conditions => ['bet_participations.status = ?', 'Accepted']
  has_many :pending_participants, :through => :participations, source: :participant, :conditions => ['bet_participations.status = ?', 'Pending']
  
end
