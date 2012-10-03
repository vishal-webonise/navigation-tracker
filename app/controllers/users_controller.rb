class UsersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :user_signed_in?
	before_filter :admin_user, only: [:index, :destroy]

	def index
		@users = User.all
	end
	
	def show
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id]).destroy
		flash[:success] = "User --> #{@user.name} is successfully deleted!"
		redirect_to :back
	end

	private

		def admin_user
      		redirect_to(user_path(current_user)) unless is_admin?
    	end
end
