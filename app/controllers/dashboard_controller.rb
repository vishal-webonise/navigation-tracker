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

  private

  def admin_user
    redirect_to :dashboard_index unless is_admin?
  end
end