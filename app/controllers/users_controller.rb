class UsersController < ApplicationController
	before_action :authenticate_user!

	def index	
		@users = set_users(params[:query])
	end

	def show
		@user = User.find(params[:id])
	end

end
