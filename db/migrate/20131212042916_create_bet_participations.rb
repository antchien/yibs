class CreateBetParticipations < ActiveRecord::Migration
  def change
    create_table :bet_participations do |t|
      t.integer :bet_id, null: false
      t.integer :user_id, null: false
      t.string :status, null: false

      t.timestamps
    end
    
    add_index :bet_participations, :bet_id
    add_index :bet_participations, :user_id
  end
end
