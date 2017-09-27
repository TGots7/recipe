class RecipeController < ApplicationController

	def index
		@user = current_user
		@instructions = Instruction.all
	end

end