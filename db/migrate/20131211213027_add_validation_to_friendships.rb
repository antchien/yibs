class AddValidationToFriendships < ActiveRecord::Migration
  def change
    add_index :friendships, [:in_friend_id, :out_friend_id], uniqueness: true
  end
end
