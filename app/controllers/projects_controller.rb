class ProjectsController < ApplicationController

  def create
    @project =current_user.projects.build(params[:project])
    if @project.save
      current_user.projects << @project
      flash[:success] = "Project created successfully"
      redirect_to projects_path
    end
  end

  def edit
    @project = Project.find(params[:id])
    @title = "Edit user"
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:success] = "Project updated."
      redirect_to :back
    end
  end

  def show
    @project = Project.find(params[:id])
  end


  def destroy
    @project = Project.find(params[:id]).destroy
    flash[:success] = "Project --> #{@project.name} is successfully deleted!"
    redirect_to :back
  end


  def index
    @projects = Project.paginate(:page => params[:page], :per_page => 10)
  end

  def tracking_code
    @project = Project.find(params[:id])
    if project_owner?(@project) || is_admin?
      render :tracking_code
    else
      redirect_to :back
    end
  end

  def project_owner?(project)
    if !project.user_projects.where('user_id = ? AND is_owner = ?', current_user.id, true).blank?
      return true
    else
      return false
    end
  end
end
