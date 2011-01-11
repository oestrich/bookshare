
Factory.define :user do |f|
  f.first_name "Test"
  f.last_name "User"
  f.sequence(:email) { |n| "example-#{n}@example.com" }
  f.password "test123"
  f.password_confirmation "test123"
end

Factory.define :book do |f|
  f.title "Book"
  #f.user Factory(:user)
  #f.location Factory(:location)
  f.isbn "1234567890"
end

Factory.define :location do |f|
  f.name "Location"
  #f.user Factory(:user)
end
