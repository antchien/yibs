class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :user_id, null: false
      t.text :terms, null: false
      t.text :wager
      t.string :status, null: false, default: "pending"
      t.boolean :private, null: false, default: false
      t.timestamps
    end
    
    add_index :bets, :user_id
  end
end
