class ApplicationController < ActionController::Base
	include Pundit
  	protect_from_forgery with: :exception

  def after_sign_out_path_for(resource_or_scope)
  	root_path
  end

  def after_sign_in_path_for(resource)
  	chef_path(current_user.id)
  end

end
