class Bet < ActiveRecord::Base
  attr_accessible :private, :status, :terms, :user_id, :wager, :participant_ids, :participants
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
  
  def bet_summary
    challengers = self.participants_ex_author
    summary = "#{self.author.full_name} bet"
    if challengers.count == 1
      summary += " #{challengers[0].full_name}"
    elsif challengers.count 2
      summary += " #{challengers[0].full_name} and #{challengers[1].full_name}"
    else
      challengers.each_with_index do |challenger, index|
        if index == challengers.length - 1
          summary += " and #{challenger.full_name}"
        else
          summary += " #{challenger.full_name},"
        end
      end
    end
    
    summary += " that #{self.terms}. Loser(s) has to #{self.wager}."
    
    case self.status
    when "pending"
      summary += " This bet is still pending."
    when "in play"
      summary += " This bet is LIVE!"
    when "completed"
      summary += " This bet is OVER.\nWinner(s):#{self.winners_summary}\nLoser(s):#{self.losers_summary}"
    when "cancelled"
      summary += " This bet has been cancelled."
    end
    
    summary
  end
  
  def winners_summary
    winners = self.winners
    summary = ""
    if winners.empty?
      return " None"
    else
      if winners.count == 1
        return " #{winners[0].full_name}"
      elsif winners.count 2
        return " #{winners[0].full_name} and #{winners[1].full_name}"
      else
        winners.each_with_index do |winner, index|
          if index == winners.length - 1
            summary += " and #{winner.full_name}"
          else
            summary += " #{winner.full_name},"
          end
        end
      end
    end
    
    summary
  end
  
  def losers_summary
    losers = self.losers
    summary = ""
    if losers.empty?
      return " None"
    else
      if losers.count == 1
        return " #{losers[0].full_name}"
      elsif losers.count 2
        return " #{losers[0].full_name} and #{losers[1].full_name}"
      else
        losers.each_with_index do |loser, index|
          if index == losers.length - 1
            summary += " and #{loser.full_name}"
          else
            summary += " #{loser.full_name},"
          end
        end
      end
    end
    
    summary
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
