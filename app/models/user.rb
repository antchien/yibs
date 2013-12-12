class User < ActiveRecord::Base
  attr_accessible :username, :password, :first_name, :last_name
  attr_reader :password

  validates :password_digest, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :session_token, :presence => true
  validates :username, :presence => true

  after_initialize :ensure_session_token

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
  primary_key: :id
  )

  has_many(
  :bet_participations,
  class_name: "BetParticipation",
  foreign_key: :user_id,
  primary_key: :id
  )

  has_many :bets, through: :bet_participations, source: :bet
  has_many :inbound_pending_bets, through: :bet_participations, source: :bet, :conditions => ['bet_participations.status = ? AND bets.status = ?', 'pending', 'pending']

  has_many(
  :authored_comments,
  class_name: "Comment",
  foreign_key: :user_id,
  primary_key: :id
  )

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def is_password?(password)
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

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
