class DashboardController < ApplicationController
  def index
  	@user = current_user
  	@project = @user.projects.build
  end

  def create_project
  	@project = current_user.projects.build(params[:project])
    if @project.save
      flash[:success] = "Project created successfully"
      redirect_to :back
    end
  end
end
