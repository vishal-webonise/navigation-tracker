class DashboardController < ApplicationController
  def index
  	@user = current_user
  	@projects = @user.projects.build
  end
end
