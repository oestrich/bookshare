class UsersController < ApplicationController

  load_and_authorize_resource

  def index

  end

  def borrowing
    @user = current_user
    @books = Book.where(:borrower_user_id => @user.id)

  end

  def borrowed
    @user = current_user

  end

end
