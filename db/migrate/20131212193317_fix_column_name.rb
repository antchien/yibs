class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :comments, :comment, :text
  end

  def down
    rename_column :comments, :text, :comment
  end
end
