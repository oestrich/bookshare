class AddRpxToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :rpx_indentifier, :string
  end

  def self.down
    remove_column :users, :rpx_indentifier
  end
end
