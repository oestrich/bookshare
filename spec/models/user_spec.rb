require 'spec_helper'

describe User do

  it { should have_many(:books) }
  it { should have_many(:requests) }
  it { should have_many(:locations) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  before :each do
    @user = Factory(:user)
  end

  it "should have a role of User" do
    @user.role.should == "user"
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
