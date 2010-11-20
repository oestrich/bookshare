class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title
      t.integer :user_id
      t.string :location
      t.text :description
      t.string :isbn

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
