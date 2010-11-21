class AddBorrowColToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :borrower_user_id, :integer
  end

  def self.down
    remove_column :books, :borrower_user_id
  end
end
