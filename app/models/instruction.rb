class Instruction < ApplicationRecord
	belongs_to :user
	has_many :instruction_ingredients
	has_many :ingredients, through: :instruction_ingredients

	def ingredients_attributes=(ingredients_hash)
		ingredients_hash.each do |i, ingredients_attributes|
			ingredient = Ingredient.find_or_create_by(name: ingredients_attributes[:name])
			self.instruction_ingredients.build(:ingredient => ingredient)
		end
		
	end


end
