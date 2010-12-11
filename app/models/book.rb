class Book < ActiveRecord::Base
  belongs_to :location
  belongs_to :user

  validates :location_id, :title, :user_id, :isbn, :presence => true
end
