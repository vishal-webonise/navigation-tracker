class Project < ActiveRecord::Base

  attr_accessible :domain, :git_url, :name, :project_mgt_tool

  validates :name, :presence => true , :length=> { :maximum => 50 } ,:uniqueness => true

  validates :domain, :presence=>true ,:uniqueness => true
  validates :git_url, :presence=>true ,:uniqueness => true
  validates :project_mgt_tool, :presence=>true

  has_and_belongs_to_many :users
  has_many :analytic_data



end
