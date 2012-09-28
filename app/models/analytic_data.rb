class AnalyticData < ActiveRecord::Base
  attr_accessible :ip_address, :project_id, :url
  belongs_to :projects
end
