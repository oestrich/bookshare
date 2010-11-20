class Book < ActiveRecord::Base
  belongs_to :location
  belongs_to :user

  validates :location_id, :presence => true
  validates :title, :presence => true
  validates :user, :presence => true
end
