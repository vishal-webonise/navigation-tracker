class ProjectsController < ApplicationController

  def new
    @project=Project.new

  end

  def create
    @project=Project.new(params[:project])
    if @project.save
      flash[:success] = "Project created successfully"
      redirect_to project_path(@project)

    end
  end

  def edit
    @project= Project.find(params[:id])
    @title = "Edit user"
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:success] = "Project updated."
      redirect_to @project
    end
  end

  def show
    #@user = User.find(params[:id])
    @project = Project.find(params[:id])
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Project destroyed."


  end

  def index
    @project=Project.show
  end
end
