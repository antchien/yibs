class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :out_friend_id, null: false
      t.integer :in_friend_id, null: false
      t.boolean :pending_flag, default: true

      t.timestamps
    end
    add_index :friendships, :out_friend_id
    add_index :friendships, :in_friend_id
  end
end
