class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		if !params[:query].blank? 
	        if params[:query] == "Alphabetical"
	            @users = User.alphabetical
	        elsif params[:query] == "Alphabetical From Z"
	            @users = User.alphabetical_from_z
	        elsif params[:query] == "Most Recipes"
	            @users = User.most_recipes
	        elsif params[:query] == "Least Recipes"
	           	@users = User.least_recipes
	        end
	      else
	        @users = User.all
	      end
	end

	def show
		@user = User.find(params[:id])
	end


end
