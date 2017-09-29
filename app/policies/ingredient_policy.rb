class IngredientPolicy < ApplicationPolicy
	attr_reader :ingredient
 
     def initialize(user, ingredient)
       super(user, ingredient)
       @ingredient = record
     end
 
     def update?
       user.admin? || ingredient.try(:user) == user
     end

     def destroy?
       user.admin? || ingredient.try(:user) == user
     end


  class Scope < Scope
    def resolve
      scope
    end
  end
end