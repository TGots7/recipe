class InstructionIngredient < ApplicationRecord
	belongs_to :ingredient
	belongs_to :instruction, dependent: :destroy
	accepts_nested_attributes_for :ingredient

	def build_ingredient=(ingredients_hash)
		ingredients_hash.each do |i, ingredients_attributes|
			if ingredients_attributes[:name].present?
				ingredient = Ingredient.find_or_create_by(name: ingredients_attributes[:name].capitalize!, organic: ingredients_attributes[:organic])
				if !self.ingredients.include?(ingredient)
					self.instruction_ingredients.build(:ingredient => ingredient).quantity=(ingredients_attributes[:quantity])
				end
			end
		end
	end

end
