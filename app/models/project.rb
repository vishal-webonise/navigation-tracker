class Project < ActiveRecord::Base
  attr_accessible :domain, :git_url, :name, :project_mgt_tool
  has_and_belongs_to_many :users
  has_many :analytic_data
end
