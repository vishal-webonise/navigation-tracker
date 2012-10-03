class ProjectsController < ApplicationController

  def new
    @project=Project.new

  end

  def create
    @project=Project.new(params[:project])
    if @project.save
      flash[:success] = "Project created successfully"
      #redirect_to root_path
      redirect_to projects_path

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
      redirect_to projects_path
    end
  end

  def show
    #@user = User.find(params[:id])
    @project = Project.find(params[:id])


  end

  def destroy
    @project=Project.find(params[:id])
    @project.destroy
    #Project.find(params[:id]).destroy
    flash[:success] = "Project destroyed."
    redirect_to projects_path


  end

  def index
    @projects=Project.all
  end
end
