class UserMailer < ActionMailer::Base
  default :from => "team@bookshare.me"

  def borrow_book_confirmation(book, borrower)
    mail(:to => book.user.email, :subject => "#{borrower.email} would like to borrow #{book.title}", :from => "team@bookshare.me")
  end
end
