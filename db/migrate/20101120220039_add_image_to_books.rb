class AddImageToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :image_url, :string
  end

  def self.down
    remove_column :books, :image_url
  end
end
