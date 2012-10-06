class ProjectsController < ApplicationController

  before_filter :find_project, only: [:edit, :show, :update, :tracking_code]

  def create
    @project =current_user.projects.build(params[:project])
    if @project.save
      current_user.projects << @project
      flash[:success] = "Project created successfully"
      redirect_to projects_path
    end
  end

  def edit
    @title = "Edit user"
    if project_owner?(@project) || is_admin?
      render :edit
    else
      redirect_to :dashboard_index
    end
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:success] = "Project updated."
      redirect_to :back
    end
  end

  def show
    if project_owner?(@project) || is_admin?
      render :show
    else
      redirect_to :dashboard_index
    end
  end

  def destroy
    @project = Project.find(params[:id]).destroy
    flash[:success] = "Project --> #{@project.name} is successfully deleted!"
    redirect_to :back
  end

  def index
    @projects = Project.paginate(:page => params[:page], :per_page => 10)
    if is_admin?
      respond_to do |format|
        format.html { render :index }
      end
    else
      redirect_to :dashboard_index
    end
  end

  def tracking_code
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

  private 

  def find_project
    @project = Project.find(params[:id])
  end
end