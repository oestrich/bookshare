class UserMailer < ActionMailer::Base
  default :from => "team@bookshare.me"

  def borrow_book_confirmation(book, borrower)
    mail(:to => book.user.email, :subject => "#{borrower.email} borrowed #{book.title}", :from => "team@bookshare.me")
  end
end
