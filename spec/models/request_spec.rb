require 'spec_helper'

describe Request do
  it { should belong_to(:user) }
  it { should belong_to(:book) }

  before :each do
    @user = Factory(:user)
    @user2 = Factory(:user)
    @location = Factory(:location, :user => @user)
    @book = Factory(:book, :user => @user, :location => @location)

    @request = Factory(:request, :user => @user, :book => @book)
  end

  it "should change book's request" do
    @request.book_request_true
    @book.requested?.should be_true

    @request.book_request_false
    @book.requested?.should be_false
  end
end
