class Instruction < ApplicationRecord
	belongs_to :user
	has_many :instruction_ingredients
	has_many :ingredients, through: :instruction_ingredients
end
