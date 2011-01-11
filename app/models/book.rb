class Book < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  has_many :requests

  validates :location_id, :title, :user_id, :isbn, :presence => true
  
  def self.new_from_isbn_or_upc(input)
    Book.new(LookupService.find_attributes_by_isbn_or_upc(input))
  end

  def request(status)
    self.requested = status
    save
  end

  def borrowed?
    !self.borrower_user_id.nil?
  end

  def borrow_status
    if borrowed?
      b_user = User.find(self.borrower_user_id)
      return "#{b_user.first_name} #{b_user.last_name} is borrowing this book." 
    end
    ""
  end

  def book_status_css
    if !self.borrower_user_id.nil?
      return "borrowed"
    elsif self.requested?
      return "requested"
    end
    ""
  end

  def in_public_location?
    self.location.public?
  end

  def borrower
    User.find(self.borrower_user_id) if self.borrower_user_id
  end

  # TODO remove this
  def borrower_email
    borrower.email
  end
end
