class Instruction < ApplicationRecord
	belongs_to :user
	has_many :instruction_ingredients
	has_many :ingredients, through: :instruction_ingredients

	def ingredients_attributes=(ingredients_hash)
		ingredients_hash.each do |i, ingredients_attributes|
			if ingredients_attributes[:name].present?
				ingredient = Ingredient.find_or_create_by(name: ingredients_attributes[:name])
				if !self.ingredients.include?(ingredient)
					self.instruction_ingredients.build(:ingredient => ingredient)
				end
			end
		end
	end

	def self.from_today
		where("created_at >=?", Time.zone.today.beginning_of_day)
	end

	def self.old_news
		where("created_at <=?", Time.zone.today.beginning_of_day)
	end

	def self.alphabetical
		self.order('name ASC')
		# where(Ingredients.order(name: :desc))
	end

	def self.alphabetical_from_z
		self.order('name DESC')
		# Instructions.order(nickname: :desc)
	end

	def self.ing_count_a
		self.ingredients.count.order('DESC')
	end

	def self.ing_count
		self.ingredients.count.order('ASC')
		# Instructions.order(nickname: :desc)
	end

end
