class WelcomePolicy < ApplicationPolicy
	attr_reader :welcome
 
     def initialize(user, welcome)
       super(user, welcome)
       @welcome = record
     end
 
     def update?
       user.admin? || welcome.try(:user) == user
     end

     def destroy?
       user.admin? || welcome.try(:user) == user
     end


  class Scope < Scope
    def resolve
      scope
    end
  end
end