class Project < ActiveRecord::Base
	attr_accessible :name, :domain_name, :domain_url

	validates :name, :domain_name, :domain_url, :presence => true 
	validates :name, :length=> { :maximum => 50 }
	validates :name, :domain_name, :domain_url, :uniqueness => true

	has_many :user_projects, :dependent => :destroy
	has_many :users, :through => :user_projects
	has_many :analytic_data
end
