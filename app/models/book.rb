class Book < ActiveRecord::Base
  belongs_to :location

  validates :location_id, :presence => true
  validates :title, :presence => true
end
