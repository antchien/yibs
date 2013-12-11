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

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
