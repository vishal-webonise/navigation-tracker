class Project < ActiveRecord::Base
  self.include_root_in_json = false
  attr_accessible :domain, :git_url, :name, :project_mgt_tool

  has_and_belongs_to_many :users
  has_many :analytic_data


 # validates :name, :presence => true ,:length=> { :maximum => 50 }
end
