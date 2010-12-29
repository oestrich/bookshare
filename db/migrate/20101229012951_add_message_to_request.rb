class AddMessageToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :message, :string
  end

  def self.down
    remove_column :requests, :message
  end
end
