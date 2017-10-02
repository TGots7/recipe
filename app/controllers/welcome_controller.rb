class WelcomeController < ApplicationController

	def index
		if user_signed_in?
			redirect_to welcome_path(current_user.id)
		end
	end

	def show
		@user = current_user
	end

end
