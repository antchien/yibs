class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :bet_id, null: false
      t.text :comment
      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :bet_id
  end
end
