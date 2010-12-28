class Book < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  has_many :requests

  validates :location_id, :title, :user_id, :isbn, :presence => true
  
  def self.new_from_isbn_or_upc(input)
    Book.new(LookupService.find_attributes_by_isbn_or_upc(input))
  end
end
