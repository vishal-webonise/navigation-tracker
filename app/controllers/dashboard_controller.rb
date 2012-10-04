class DashboardController < ApplicationController
  def index
  	@user = current_user
    @users = User.all
    @user_list = User.all.to_json(:only => [:id, :first_name, :last_name]) 
  	@project = @user.projects.build
  end

  def user_projects
    query = params[:q]
    @user_projects = current_user.projects.where("name LIKE ?", "%#{query}%")
    respond_to do |format|
      format.json { render :json => @user_projects }
    end
  end

  def assign_project_users
    @user_project_id = params[:user_project]
    @project_users_ids = params[:project_users]
  end

end