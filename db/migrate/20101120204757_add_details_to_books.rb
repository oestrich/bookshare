class AddDetailsToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :details_url, :string
  end

  def self.down
    remove_column :books, :details_url
  end
end
