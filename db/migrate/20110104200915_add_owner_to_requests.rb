class AddOwnerToRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :owner_id, :integer

    Request.all.each do |request|
      request.owner_id = request.book.user.id
      request.save
    end
  end

  def self.down
    remove_column :requests, :owner_id
  end
end
