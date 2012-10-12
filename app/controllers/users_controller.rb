class UsersController < ApplicationController

  before_filter :user_signed_in?
  before_filter :authenticate_user!
  before_filter :admin_user, only: [:destroy, :admin_accessible_change, :admin_accessible_update]


  def index
    @users = User.paginate(:page => params[:page])
    if !params[:q].nil?
      query = params[:q]
      @assign_users = User.where("first_name LIKE  ? OR last_name LIKE ?", "%#{query}%", "%#{query}%")
      respond_to do |format|
        format.json { render :json => @assign_users.as_json(:only => [:id, :first_name, :last_name]) }
      end
    else
      if is_admin?
        respond_to do |format|
          format.html { render :index, layout: 'layouts/admin' }
        end
      else
        redirect_to :dashboard_index
      end
    end
  end

  def show
    if is_admin?
      @user = User.find(params[:id])
      render layout: 'layouts/admin'
    else
      redirect_to dashboard_index_path + '#all_projects'
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

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = "User #{@user.first_name} is successfully deleted!"
    redirect_to :back
  end

  def edit
    if User.exists?(params[:id])
      @user = User.find(params[:id])
      if current_user == @user
        @user
      else
        redirect_to edit_user_path(current_user)
      end
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    logger.info("###############################{params[:user]}")
    if @user.update_attributes(params[:user])
      # sign_in(@user, :bypass => true)
      flash[:success] = "Profile updated."
      redirect_to :dashboard_index
    else
      # flash[:error] = @user.errors.each {|e| puts e}
      render 'edit'
    end
  end

  def update_password
    if current_user.valid_password?(params[:user][:current_password])
      if current_user.update_with_password(params[:user])
        sign_in(current_user, :bypass => true)
        flash[:success] = "Password updated."
        redirect_to dashboard_index_path
      else
        redirect_to :back, :notice => "New password do not match"
      end
    else
      flash[:error] = "Please enter your current password"
      redirect_to :back
    end
  end

  def admin_accessible_change
    @user = User.find(params[:id])
    render layout: 'layouts/admin'
  end

  def admin_accessible_update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User details updated."
      UserMailer.change_user_details_by_admin_email(@user).deliver
      redirect_to users_path
    else
      flash[:error] = "Passwords do not match."
      redirect_to admin_accessible_change_user_path
    end
  end


  private

  def admin_user
    redirect_to :dashboard_index unless is_admin?
  end


end