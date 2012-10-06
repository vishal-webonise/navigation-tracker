class DashboardController < ApplicationController

  before_filter :authenticate_user!
  before_filter :admin_user, :only => [:admin]

  def index
    if is_admin?
      redirect_to admin_dashboard_index_path
    else
    	@user = current_user
      @users = User.all
      @user_list = User.all.to_json(:only => [:id, :first_name, :last_name]) 
    	@project = @user.projects.build
    end
  end

  def admin
    @users = User.all
    @projects = Project.all
    render layout: 'layouts/admin'
  end

  def user_projects
    query = params[:q]
    @user_projects = current_user.projects.where("name LIKE ?", "%#{query}%")
    respond_to do |format|
      format.json { render :json => @user_projects }
    end
  end

  def project_users
    project_id = params[:project_id]
    logger.info("\n####################Project id = #{params[:project_id]}\n")
    @project_users = Project.find(project_id).users.to_json(:only => [:id, :first_name, :last_name])
    respond_to do |format|
      format.json { render :json => @project_users }
    end
  end

  def assign_project_users
    @user_project_id = params[:user_project]
    @project_users_ids = params[:project_users].split(",").to_a
    user_project = Project.find(@user_project_id).user_projects.new
    @project_users_ids.each do |user_id|
      if user_id != current_user.id
        user_project.user_id = user_id
        user_project.is_owner = false
        user_project.save
      end
    end
    flash[:success] = "User(s) assigned successfully"
    redirect_to :back
  end

  private

  def admin_user
    redirect_to :dashboard_index unless is_admin?
  end
end