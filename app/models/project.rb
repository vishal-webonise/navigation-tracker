class Project < ActiveRecord::Base
  self.include_root_in_json = false

  attr_accessible :name, :domain_name, :domain_url

  #validates :name, :presence => true , :length=> { :maximum => 50 } ,:uniqueness => true ,:on => :create

 # validates :domain_name, :presence=>true ,:uniqueness => true ,:on => :create
  #validates :domain_url, :presence=>true ,:uniqueness => true  ,:on => :create


  has_many :users, through: :user_project
  has_many :user_project

  has_many :analytic_data

end
