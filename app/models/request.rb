class Request < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  after_create :book_request_true
  after_create :set_owner_id_from_book
  before_destroy :book_request_false

  def set_owner_id_from_book
    self.owner_id = self.book.user.id
  end

  def book_request_true
    self.book.request true
  end

  def book_request_false
    self.book.request false
  end
end
