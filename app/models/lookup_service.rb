class LookupService
  class << self
    include ASIN
  end
  
  self.configure :secret => 'G6aSVuRonDppc5l1U10dRZW360LL+b3khm/9G6q9', :key => '0HFCVPEF9DTHP5DXV482'
  
  def self.find_attributes_by_isbn_or_upc(input)
    input = clean_input_code(input)
    find_attributes_by_isbn(input) || find_attributes_by_upc(input)
  end
  
  def self.find_attributes_by_upc(input)
    self.find_attributes_by_isbn(convert_upc_to_isbn(input))
  end
  
  def self.find_attributes_by_isbn(isbn)  
    begin
      item = lookup(isbn)    
      {:title => item.title,
       :asin  => item.raw.ASIN,
       :details_url => item.raw.DetailPageURL,
       :image_url => self.find_image_by_isbn(isbn),
       :lowest_used_price => self.find_lowest_offer_by_isbn(isbn),
       :author => self.create_authors_string_from_response(item),
       :isbn => isbn
      }            
    rescue
      nil
    end
  end
  
  def self.find_image_by_isbn(isbn)
    lookup(isbn, {:ResponseGroup => "Images"}).raw.ImageSets.ImageSet.MediumImage.URL
  end
  
  def self.find_lowest_offer_by_isbn(isbn)
    lookup(isbn, {:ResponseGroup => "Offers"}).raw.OfferSummary.LowestUsedPrice.FormattedPrice
  end
  
private
  def self.create_authors_string_from_response(item)
    if item.raw.ItemAttributes.Author.respond_to?(:join)
      item.raw.ItemAttributes.Author.join ", "
    else
      item.raw.ItemAttributes.Author
    end     
  end
  
  def self.clean_input_code(input)
    input.delete("\s-.")
  end
  
  def self.convert_upc_to_isbn(upc)
    return nil if upc.nil? || upc.empty?
    # loosely based on http://snipplr.com/view/13299/convert-upc-to-isbn/
    isbn = upc[3..-2]
    add = 0
    count = 10
    index = 0
    while index < isbn.length()
        a = isbn[index..index]
        add += a.to_i() * count
        index += 1
        count -= 1
    end
    xsum = 11 - (add % 11)
    if xsum == 10
        xsum = "X"
    elsif xsum == 11
        xsum = 0
    end
    isbn += xsum.to_s()
    return isbn
  end
end
