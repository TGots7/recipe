class InstructionIngredient < ApplicationRecord
	belongs_to :ingredient
	belongs_to :instruction, dependent: :destroy

end
