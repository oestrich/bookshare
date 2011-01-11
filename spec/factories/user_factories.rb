Factory.define :user do |f|
  f.first_name "Test"
  f.last_name "User"
  f.email "example@example.com"
  f.password "test123"
  f.password_confirmation "test123"
end
