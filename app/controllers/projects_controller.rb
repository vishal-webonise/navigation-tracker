class ProjectsController < ApplicationController

  before_filter :find_project, only: [:edit, :show, :update, :tracking_code]

  def create
    @project = current_user.projects.build(params[:project])
    if @project.save
      current_user.projects << @project
      flash[:success] = "Project created successfully"
      redirect_to projects_path
    end
  end

  def edit
    if project_owner?(@project.id)
      render :edit
    else
      redirect_to :dashboard_index
    end
  end

  def update
    if project_owner?(@project.id)
      if @project.update_attributes(params[:project])
        flash[:success] = "Project details updated"
        redirect_to tracking_code_for_project_path(@project)
      end
    else
      redirect_to root_path
    end
  end

  def show
    if project_owner?(@project.id)
      render :show
    elsif is_admin?
      render :show, layout: 'layouts/admin'
    else
      redirect_to :dashboard_index
    end
  end

  def destroy
    if project_owner?(params[:id]) || is_admin?
      @project = Project.find(params[:id]).destroy
      flash[:success] = "Project #{@project.name} is successfully deleted"
      redirect_to :dashboard_index
    end
  end

  def index
    @projects = Project.paginate(:page => params[:page], :per_page => 10)
    if is_admin?
      respond_to do |format|
        format.html { render :index, layout: 'layouts/admin' }
      end
    else
      redirect_to :dashboard_index
    end
  end

  def tracking_code
    if project_owner?(@project.id)
      render :tracking_code
    else
      redirect_to :dashboard_index
    end
  end

  private 

  def find_project
    @project = Project.find(params[:id])
  end
end