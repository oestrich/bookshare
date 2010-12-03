class AddLowestUsedPriceToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :lowest_used_price, :string
  end

  def self.down
    remove_column :books, :lowest_used_price
  end
end
