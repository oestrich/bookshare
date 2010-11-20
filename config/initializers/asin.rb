require 'asin'
include ASIN

# use the configure method to setup your api credentials
configure :secret => 'G6aSVuRonDppc5l1U10dRZW360LL+b3khm/9G6q9', :key => '0HFCVPEF9DTHP5DXV482'

# lookup an item with the amazon standard identification number (asin)
item = lookup '1430218150'

# have a look at the title of the item
item.title
=> Learn Objective-C on the Mac (Learn Series)

# access the internal data representation (Hashie::Mash)
item.raw.ItemAttributes.ListPrice.FormattedPrice
=> $39.99