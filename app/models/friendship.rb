class Friendship < ActiveRecord::Base
  attr_accessible :in_friend_id, :out_friend_id, :pending_flag
  validates :in_friend, :out_friend, presence: true
  validates :in_friend_id, :uniqueness => {:scope => :out_friend_id}

  before_save :check_recip_friendship

  belongs_to(
  :in_friend,
  class_name: "User",
  foreign_key: :in_friend_id,
  primary_key: :id
  )

  belongs_to(
  :out_friend,
  class_name: "User",
  foreign_key: :out_friend_id,
  primary_key: :id
  )

  def self.find_by_ids(out_friend_id, in_friend_id)
    Friendship.find_by_out_friend_id_and_in_friend_id(out_friend_id, in_friend_id)
  end

  def find_recip_friendship
    Friendship.find_by_in_friend_id_and_out_friend_id(self.out_friend_id, self.in_friend_id)
  end

  def check_recip_friendship
    recip_friendship = self.find_recip_friendship
    if recip_friendship && recip_friendship.pending_flag
      puts recip_friendship
      recip_friendship.update_attribute(:pending_flag, false)
      self.pending_flag = false;
    end
    true
  end

end
