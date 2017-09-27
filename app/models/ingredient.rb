class Ingredient < ApplicationRecord
	has_many :instruction_ingredients
	has_many :instructions, through: :instruction_ingredients
end
