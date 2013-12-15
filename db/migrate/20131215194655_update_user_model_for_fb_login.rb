class UpdateUserModelForFbLogin < ActiveRecord::Migration
  def up
    change_column :users, :password_digest, :string, null: true
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end

  def down
    change_column :users, :password_digest, :string, null: false
    remove_column :users, :uid
    remove_column :users, :provider
  end
end
