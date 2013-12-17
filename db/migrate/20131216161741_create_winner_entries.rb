class CreateWinnerEntries < ActiveRecord::Migration
  def change
    create_table :winner_entries do |t|
      t.integer :user_id, null: false
      t.integer :bet_id, null: false

      t.timestamps
    end
    add_index :winner_entries, :user_id
    add_index :winner_entries, :bet_id
  end
end
