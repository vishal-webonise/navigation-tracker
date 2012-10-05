class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :user_signed_in?
  before_filter :admin_user, only: [:destroy]

  def index
  	@users = User.all

    if !params[:q].nil?
      query = params[:q]
      @assign_users = User.where("first_name LIKE  ? OR last_name LIKE ?", "%#{query}%", "%#{query}%")
      respond_to do |format|
        format.json { render :json => @assign_users.as_json(:only => [:id, :first_name, :last_name]) }
      end
    else
      if is_admin?
        respond_to do |format|
          format.html { render :index }
        end
      else
        redirect_to :dashboard_index
      end
    end
  end

  def create_project
    @project = current_user.projects.build(params[:project])
    if @project.save
      current_user.projects << @project
      flash[:success] = "Project created successfully"
      redirect_to tracking_code_for_project_path(current_user.projects.last)
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  def destroy
  	@user = User.find(params[:id]).destroy
  	flash[:success] = "User --> #{@user.first_name} is successfully deleted!"
  	redirect_to :back
  end

  private

  	def admin_user
    	redirect_to(user_path(current_user)) unless is_admin?
  	end
end