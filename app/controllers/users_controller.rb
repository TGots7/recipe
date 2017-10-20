class UsersController < ApplicationController
	before_action :authenticate_user!

	def index	
		@users = set_users(params[:query])
	end

	def show
		@user = User.find(params[:id])
	end

	def patch
		current_user.update(update_params)
	end

	def update_params
    	params.require(:user).permit(:avatar)
  	end

end
