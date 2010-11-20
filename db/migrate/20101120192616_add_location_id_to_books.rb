class AddLocationIdToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :location_id, :integer
  end

  def self.down
    remove_column :books, :location_id
  end
end
