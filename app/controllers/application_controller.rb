class ApplicationController < ActionController::Base
	protect_from_forgery

	include UsersHelper

	private 
	  def stored_location_for(resource_or_scope)
	    nil
	  end

	  def after_sign_in_path_for(resource_or_scope)
	    if is_admin?
	    	admin_dashboard_index_path
	    else
	    	dashboard_index_path
	    end
	  end
end
