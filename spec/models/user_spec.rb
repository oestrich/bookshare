require 'spec_helper'

describe User do
  before :each do
    @user = Factory(:user)
  end

  it "should have a name of 'Test User'" do
    @user.name.should == "#{@user.first_name} #{@user.last_name}"
  end

  describe User, "no requested books" do
    it "should have no requested books" do
      @user.my_requested.count.should == 0
    end
  end
end
