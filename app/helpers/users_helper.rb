module UsersHelper
	
	def set_users(params)
		if !params.blank? 
		        if params == "Alphabetical"
		            @users = User.alphabetical
		        elsif params == "Alphabetical From Z"
		            @users = User.alphabetical_from_z
		        elsif params == "Most Recipes"
		            @users = User.most_recipes
		        elsif params == "Least Recipes"
		           	@users = User.least_recipes
		        end
		      else
		        @users = User.all
		      end
	end
	
end
