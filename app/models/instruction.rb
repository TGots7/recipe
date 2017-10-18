class Instruction < ApplicationRecord
	belongs_to :user
	has_many :instruction_ingredients, dependent: :destroy
	has_many :ingredients, through: :instruction_ingredients
	validates :name, :content, :cook_time, presence: true
	validates :name, uniqueness: true

	def to_param
    	"#{id}-#{name}"
  	end

	def instruction_ingredients_attributes=(ingredients_hash)
		binding.pry
		ingredients_hash.each do |i, ingredients_attributes|
			if ingredients_attributes[:name].present?
				ingredient = Ingredient.find_or_create_by(name: ingredients_attributes[:name].capitalize!, organic: ingredients_attributes[:organic])
				if !self.ingredients.include?(ingredient)
					self.instruction_ingredients.build(:ingredient => ingredient).quantity=(ingredients_attributes[:quantity])
				end
			end
		end
	end

	

	def self.from_today
		where("created_at >= ?", Time.zone.today.beginning_of_day)
	end

	def self.old_news
		where("created_at <= ?", Time.zone.today.beginning_of_day)
	end

	def self.alphabetical
		self.order('name ASC')
	end

	def self.alphabetical_from_z
		self.order('name DESC')
	end

	def self.least_ingredients
		self.all.sort_by{ |ins| ins.ingredients.count}
	end

	def self.most_ingredients
		self.all.sort_by{ |ins| ins.ingredients.count}.reverse
	end

end
