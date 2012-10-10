class AnalyticData < ActiveRecord::Base
  attr_accessible :ip_address, :project_id, :visit_path, :reference_path
  belongs_to :projects
end
