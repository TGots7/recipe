class InstructionPolicy < ApplicationPolicy
	attr_reader :instruction
 
     def initialize(user, instruction)
       super(user, instruction)
       @instruction = record
     end
 
     def update?
       user.admin? || instruction.try(:user) == user
     end

     def destroy?
       user.admin? || instruction.try(:user) == user
     end


  class Scope < Scope
    def resolve
      scope
    end
  end
end
