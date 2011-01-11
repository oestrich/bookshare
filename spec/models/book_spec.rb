require 'spec_helper'

describe Book do
  it { should have_many(:requests) }
  it { should belong_to(:user) }
  it { should belong_to(:location) }

  before :each do
    @user = Factory(:user)
    @location = Factory(:location, :user => @user)
    @book = Factory(:book, :user => @user, :location => @location)
  end
end
