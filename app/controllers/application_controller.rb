class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :catch_cancel, :on => [:create, :update, :destroy]

  include UsersHelper

  def project_owner?(project_id)
    if !Project.find(project_id).user_projects.where('user_id = ? AND is_owner = ?', current_user.id, true).blank?
      return true
    else
      return false
    end
  end

  private

  def stored_location_for(resource_or_scope)
    nil
  end

  def after_sign_in_path_for(resource_or_scope)
    if is_admin?
      admin_dashboard_index_path
    else
      dashboard_index_path
    end
  end

  def catch_cancel
    redirect_to root_path if params[:commit] == "Cancel"
  end
end