
Factory.define :user do |f|
  f.first_name "Test"
  f.sequence(:last_name) { |n| "User #{n}" }
  f.sequence(:email) { |n| "example-#{n}@example.com" }
  f.password "test123"
  f.password_confirmation "test123"
end

Factory.define :book do |f|
  f.sequence(:title) { |n| "Book #{n}" }
  f.association :user
  f.association :location
  f.isbn "1234567890"
end

Factory.define :location do |f|
  f.sequence(:name) { |n| "Location #{n}" }
  f.association :user
end

Factory.define :request do |f|
  f.association :user
  f.association :book
end
