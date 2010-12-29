class AddPublicToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :public, :boolean, :default => 0
  end

  def self.down
    remove_column :locations, :public
  end
end
