class AddNotificationTimeStampToUser < ActiveRecord::Migration
  def change
    add_column :users, :notification_checked_at, :timestamp
  end
end
