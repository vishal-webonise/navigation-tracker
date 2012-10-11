class ProjectsController < ApplicationController

  before_filter :exists?, only: [:edit, :update, :show, :users, :assign_users]
  before_filter :find_project, only: [:edit, :show, :update, :tracking_code, :users]

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
    @project = Project.find(params[:id])
    @analytic_data = @project.analytic_datas
    @ip_addresses = @analytic_data.group_by{ |i| i.ip_address }
    # @results = @ip_addresses.collect{ |i,v| i + "," + v.last.created_at.to_s + "," + v.count.to_s + v.select{ |l| [DateTime.now.yesterday...DateTime.now].include?(l.created_at)}.join(",")}
    @results = @ip_addresses.collect{ |i,v| i + "," + v.last.created_at.to_s + "," + v.count.to_s }
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

  def users
    query = params[:q]
    if project_owner?(@project.id)
      @project_users = @project.users.where('users.id = user_projects.user_id AND user_projects.is_owner = ?', false)
      @project_user_ids = Project.find(@project.id).user_ids
      @project_users_list = User.all(:select => "id, first_name, last_name", :conditions => ["id NOT IN (?) AND email NOT LIKE ? AND (first_name LIKE  ? OR last_name LIKE ?)", @project_user_ids, "admin@analytics.com", "%#{query}%", "%#{query}%"]).to_json
      logger.info("##########################{@project_users_list}")
    else
      redirect_to :dashboard_index
    end
    respond_to do |format|
      format.html { render 'users' }
      format.json { render :json => @project_users_list.present? ? @project_users_list.as_json : {}}
    end
  end

  def assign_users
    logger.info("#######################In Assign Users: #{params.inspect}")
    @project_id = params[:project_id]
    @project_users_ids = params[:project_users].split(",").to_a
    user_project = Project.find(@project_id).user_projects.new
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

  def unassign_user
    logger.info("######################Unassign User data: #{params.inspect}")
    @project_id = params[:id]
    @user_id = params[:user_id]
      if project_owner?(params[:id])
        UserProject.where('project_id = ? AND user_id = ? AND is_owner = ?', @project_id, @user_id, false).first.destroy
        flash[:success] = "User unassigned successfully"
        redirect_to :dashboard_index
      end
  end

  def visitor_behaviour
    logger.info("######################Project_ID => #{params[:id]}, Visitor_IP => #{params[:ip]}")
    @visit_hour_groups = Project.find(params[:id]).analytic_datas.where('ip_address = ?', params[:ip]).order('created_at DESC').select('concat(month(created_at),"-",year(created_at),"-",hour(created_at)) as tracking_hour, visit_path, reference_path').group_by{|i| i.tracking_hour}

    if project_owner?(params[:id])
      render :visitor_behaviour
    elsif is_admin?
      render :visitor_behaviour, layout: 'layouts/admin'
    else
      redirect_to :dashboard_index
    end
  end

  private 

  def find_project
    @project = Project.find(params[:id])
  end

  def exists?
    redirect_to :dashboard_index unless Project.exists?(params[:id])
  end
end