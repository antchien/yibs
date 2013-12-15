class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.string :text, null: false
      t.string :link

      t.timestamps
    end
    add_index :notifications, :user_id
  end
end
