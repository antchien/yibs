class Bet < ActiveRecord::Base
  attr_accessible :private, :status, :terms, :user_id, :wager, :participant_ids
  validates :status, :terms, :user_id, presence: true
  validates :status, :inclusion => {:in => ['pending', 'in play', 'completed', 'cancelled']}
  validates :private, :inclusion => {:in => [true, false]}
  before_save :set_default_status_pending


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
  #has_many :participants_ex_author, :through => :participations, source: :participant, :conditions => ['users.id = ?', '#{self.user_id}']
  has_many :accepted_participants, :through => :participations, source: :participant, :conditions => ['bet_participations.status = ?', 'accepted']
  has_many :pending_participants, :through => :participations, source: :participant, :conditions => ['bet_participations.status = ?', 'pending']

  has_many(
  :comments,
  class_name: "Comment",
  foreign_key: :bet_id,
  primary_key: :id
  )

  has_many :commenters, :through => :comments, source: :author, :uniq => true

  has_many(
  :winning_entries,
  class_name: "WinnerEntry",
  foreign_key: :bet_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(
  :losing_entries,
  class_name: "LoserEntry",
  foreign_key: :bet_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many :winners, :through => :winning_entries, source: :winner
  has_many :losers, :through => :losing_entries, source: :loser

  def all_participants_accepted?
    participations.all? { |participation| participation.status == "accepted" }
  end

  def participation_author
    participations.select { |participation| participation.user_id == self.author.id }
  end

  def participants_ex_author
    participants.select { |participant| participant != self.author }
  end

  def participations_ex_author
    participations.select { |participation| participation.user_id != self.author.id }
  end

  def time_since_last_update
    age = Time.now()-self.updated_at
    if age > 259200
      return self.updated_at.strftime("on %B %e, %Y at %-I:%M%P")
    elsif age > 172800
      return (age / 86400).floor.to_s + " days ago"
    elsif age > 86400
      return self.updated_at.strftime("yesterday at %-I:%M%P")
    elsif age > 3600
      return (age / 3600).floor.to_s + " hours ago"
    else age
      return (age / 60).floor.to_s + " minutes ago"
    end
  end

  def set_default_status_pending
    if !self.status
      self.status = "pending"
    end
  end
end
