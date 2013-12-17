class CreateLoserEntries < ActiveRecord::Migration
  def change
    create_table :loser_entries do |t|
      t.integer :user_id, null: false
      t.integer :bet_id, null: false

      t.timestamps
    end

    add_index :loser_entries, :user_id
    add_index :loser_entries, :bet_id
  end
end
