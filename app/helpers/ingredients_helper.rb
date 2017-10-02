module IngredientsHelper

	def set_ingredients(params)
		if !params.blank? 
	        if params == "Alphabetical"
	            @ingredients = Ingredient.alphabetical
	        elsif params == "Alphabetical From Z"
	            @ingredients = Ingredient.alphabetical_from_z
	        elsif params == "Most Recipes"
	            @ingredients = Ingredient.most_recipes
	        elsif params == "Least Recipes"
	           @ingredients = Ingredient.least_recipes
	        end
	      else
	        @ingredients = Ingredient.all
	      end
	    end
end
