class UserMailer < ActionMailer::Base
  default :from => "team@bookshare.me"

  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Bookshare Registration", :from => "team@bookshare.me")
  end
end
