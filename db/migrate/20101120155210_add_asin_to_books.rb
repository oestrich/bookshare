class AddAsinToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :asin, :string
  end

  def self.down
    remove_column :books, :asin
  end
end
