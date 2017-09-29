class UserPolicy < ApplicationPolicy
	attr_reader :user
 
     def initialize(users, user)
       super(users, user)
       @user = record
     end
 
     def update?
       user.admin? || user.try(:users) == users
     end

     def destroy?
       user.admin? || user.try(:users) == users
     end


  class Scope < Scope
    def resolve
      scope
    end
  end
end