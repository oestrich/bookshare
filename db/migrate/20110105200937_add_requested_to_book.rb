class AddRequestedToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :requested, :boolean, :default => false

    Request.all.each do |request|
      request.book.requested = true
      request.book.save
    end
  end

  def self.down
    remove_column :books, :requested
  end
end
