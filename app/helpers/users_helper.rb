module UsersHelper

	def is_admin?
		current_user.login_type == "admin"
	end

	# Returns the Gravatar for the given user
	def gravatar_for(user, options = { size:50 })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: "#{user.first_name} #{user.last_name}", class: 'gravatar img-polaroid')
	end

	def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
