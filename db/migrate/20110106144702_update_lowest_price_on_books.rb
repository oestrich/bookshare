class UpdateLowestPriceOnBooks < ActiveRecord::Migration
  def self.up
    Book.all.each do |book|
      if book.lowest_used_price.nil?
        book.lowest_used_price = LookupService.find_lowest_offer_by_isbn(book.isbn)
        book.save
        sleep 0.5
      end
    end
  end

  def self.down
  end
end
