class DashboardController < ApplicationController
  def index
  	@user = current_user
  	@project = @user.projects.build
  end

  def create_project
  	@project = current_user.projects.build(params[:project])
    if @project.save
    	current_user.projects << @project
      flash[:success] = "Project created successfully"
      redirect_to projects_path
    #redirect_to :back
    end
  end



  def user_projects
    query = params[:q]
    @user_projects = current_user.projects.where("name LIKE ?", "%#{query}%")
    respond_to do |format|
      format.json { render :json => @user_projects }
    end
  end


end