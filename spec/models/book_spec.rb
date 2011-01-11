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

  describe Book, "not borrowed" do
    it "should not be borrowed" do
      @book.borrowed?.should be_false
    end

    it "should have a status of ''" do
      @book.borrow_status.should == ""
    end

    it "should have a book css of ''" do
      @book.book_status_css.should == ""
    end

    it "should not have a borrower" do
      @book.borrower.should be_nil
    end
  end

  describe Book, "borrowed" do
    before :each do 
      @borrower = Factory(:user)
      @book.borrower_user_id = @borrower.id
      @book.save
    end

    it "should be borrowed" do 
      @book.borrowed?.should be true
    end

    it "should have a status" do 
      @book.borrow_status.should == "#{@borrower.name} is borrowing this book."
    end

    it "should have a book css of 'borrowed'" do
      @book.book_status_css.should == "borrowed"
    end

    it "should have a borrower" do
      @book.borrower.should == @borrower
    end
  end
end
