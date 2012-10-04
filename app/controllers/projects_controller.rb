class ProjectsController < ApplicationController

  def create
    @project = Project.new(params[:project])
    if @project.save
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
      redirect_to projects_path


    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:success] = "Project destroyed."
    redirect_to projects_path
  end

  def index
    @projects=Project.all
  end

  def search
    @projects = Project.where("name LIKE ?", "%params[:q]%")
    respond_to do |format|
      @projects.each do |p|
        data={:id=> p.id ,:name=> p.name}
        format.json{render :json => @data }
      end
    end
  end
end
