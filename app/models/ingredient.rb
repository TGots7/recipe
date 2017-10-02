class Ingredient < ApplicationRecord
	has_many :instruction_ingredients
	has_many :instructions, through: :instruction_ingredients
	validates :name, presence: true

	def self.alphabetical
		self.order('name ASC')
		# where(Ingredients.order(name: :desc))
	end

	def self.alphabetical_from_z
		self.order('name DESC')
		# Instructions.order(nickname: :desc)
	end

	def self.least_recipes
		self.all.sort_by{ |ing| ing.instructions.count}
	end

	def self.most_recipes
		self.all.sort_by{ |ing| ing.instructions.count}.reverse
	end

end
