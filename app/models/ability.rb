class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new() # guest user

    # Probably shouldn't be this way...
    if user.email == '' 
      user.role = "guest"
    end

    alias_action :view, :to => :read
    
    if user.role == "admin"
      can :manage, :all
    end
      
    if user.role == "user"
      can :read, Book
      can :create, Book
      can :borrow, Book
      can :return, Book

      can :manage, Location, :user_id => user.id
    end
    
    if user.role == "guest"
      can :read, Book 
    end

  end
end
