class Project < ActiveRecord::Base

  attr_accessible :domain, :git_url, :name, :project_mgt_tool

  has_and_belongs_to_many :users
  has_many :analytic_data


 # validates :name, :presence => true ,:length=> { :maximum => 50 }
  #validates :domain, :presence=>true
 # validates :git_url, :presence=>true
 # validates :project_mgt_tool, :presence=>true

end
