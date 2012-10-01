class UsersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :is_admin?, only: [:index]
	
	def index

	end
end
