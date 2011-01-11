require 'spec_helper'

describe Location do
  it { should belong_to(:user) }
  it { should have_many(:books) }

  before :each do
    @user = Factory(:user)
    @location = Factory(:location, :user => @user)
  end

  it "should have 0 books" do
    @location.books.count.should == 0
  end
end
