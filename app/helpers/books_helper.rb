module BooksHelper
end

# loosely based on http://snipplr.com/view/13299/convert-upc-to-isbn/
# returns ISBN-10

def convert(upc)
    """Returns isbn string"""
    isbn = upc[3..-2]
    add = 0
    count = 10
    index = 0
    while index < isbn.length():
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

#begin
#    upc = ARGV[0]
#    upc = upc.to_s()
#    if upc.length() == 13 && upc[0..2] == "978"
#        puts convert(upc)
#    else
#        puts "UPC length must be 13"
#    end
#rescue
#    puts "Please input UPC"
#end

