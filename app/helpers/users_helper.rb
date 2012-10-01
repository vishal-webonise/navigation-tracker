module UsersHelper
	def is_admin?
		current_user.login_type == "admin"
	end
end
