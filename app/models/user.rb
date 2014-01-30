require 'open-uri'

class User < ActiveRecord::Base
  include PgSearch

  attr_accessible :username, :password, :first_name, :last_name, :profile_pic, :provider, :uid, :notification_checked_at
  attr_reader :password

  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :session_token, :presence => true
  validates :username, :presence => true

  after_initialize :ensure_session_token
  before_save :initialize_notification_checked_at
  #before_save :set_default_pic

  pg_search_scope :search_by_name_and_email, against: [:first_name, :last_name, :username], :using => {:tsearch => {:prefix => true}}

  has_attached_file :profile_pic, :styles => {
    :medium => "250x250#",
    :small => "50x50#",
    :thumb => "30x30#"},
    :default_url => ":style/missing.png"

  has_many(
  :outbound_friendships,
  class_name: "Friendship",
  foreign_key: :out_friend_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(
  :inbound_friendships,
  class_name: "Friendship",
  foreign_key: :in_friend_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many :friends, through: :outbound_friendships, source: :in_friend, :conditions => ['Friendships.pending_flag = ?', false]
  has_many :outbound_pending_friends, through: :outbound_friendships, source: :in_friend, :conditions => ['Friendships.pending_flag = ?', true]
  has_many :inbound_pending_friends, through: :inbound_friendships, source: :out_friend, :conditions => ['Friendships.pending_flag = ?', true]


  has_many(
  :authored_bets,
  class_name: "Bet",
  foreign_key: :user_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(
  :bet_participations,
  class_name: "BetParticipation",
  foreign_key: :user_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many :bets, through: :bet_participations, source: :bet
  has_many :inplay_bets, through: :bet_participations, source: :bet, :conditions => ['bets.status = ?', 'in play']
  has_many :inbound_pending_bets, through: :bet_participations, source: :bet, :conditions => ['bet_participations.status = ? AND bets.status = ?', 'pending', 'pending']
  has_many :community_bets, through: :friends, source: :bets

  has_many(
  :authored_comments,
  class_name: "Comment",
  foreign_key: :user_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(
  :notifications,
  class_name: "Notification",
  foreign_key: :user_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(
  :winning_entries,
  class_name: "WinnerEntry",
  foreign_key: :user_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many(
  :losing_entries,
  class_name: "LoserEntry",
  foreign_key: :user_id,
  primary_key: :id,
  dependent: :destroy
  )

  has_many :bets_won, :through => :winning_entries, source: :bet
  has_many :bets_lost, :through => :losing_entries, source: :bet

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
    #to account for users that login via 3rd party FB/Twitter accts, for which they dont' have a yibs pw
    return false if !self.password_digest
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end

  def find_friendship(friend)
    Friendship.find_by_out_friend_id_and_in_friend_id(self.id, friend.id)
  end

  def find_bet_participation(bet)
    BetParticipation.find_by_user_id_and_bet_id(self.id, bet.id)
  end

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

  def abbrev_name
    return "#{self.first_name} #{self.last_name[0] if self.last_name}"
  end

  def community_bets
  @bets = self.bets
    self.friends.each do |friend|
      @bets = (@bets + friend.bets.where( private: false ) ).uniq
    end
    @bets.sort_by { |bet| Time.now()-bet.updated_at }
  end

  def pending_bets
    @bets = self.bets.where( status: 'pending' )
    @bets.sort_by { |bet| Time.now()-bet.updated_at }
  end

  def inplay_bets
    @bets = self.bets.where( status: 'in play' )
    @bets.sort_by { |bet| Time.now()-bet.updated_at }
  end

  def completed_bets
    @bets = self.bets.where( status: 'completed' )
    @bets.sort_by { |bet| Time.now()-bet.updated_at }
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def set_default_pic
    if !self.profile_pic.present?
      self.profile_pic = open("http://www.tenniswood.co.uk/wp-content/uploads/2010/01/design-fetish-no-photo-facebook-1.jpg")
    end
  end
  
  def initialize_notification_checked_at
    self.notification_checked_at ||= Time.now()
  end
end
