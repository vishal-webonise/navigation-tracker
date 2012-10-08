class Project < ActiveRecord::Base
  attr_accessible :name, :domain_name, :domain_url
  self.per_page = 10

  validates :name ,:presence => { :message => "Project name can't be blank" }
  validates_length_of :name, minimum: 1, maximum: 50, :message => "Project name should be between 1 to 50 characters"
  validates :domain_name ,:presence => { :message => "Domain name can't be blank" }
  validates :domain_url ,:presence => { :message => "Domain URL can't be blank" }

  validates :name, :uniqueness => { :message => "Project name should be unique" }
  validates :domain_name, :uniqueness => { :message => "Domain name should be unique" }
  validates :domain_url, :uniqueness => { :message => "Domain URL should be unique" }

  validates_format_of :domain_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/i, :message => "Enter a valid domain URL"

	has_many :user_projects, :dependent => :destroy
	has_many :users, :through => :user_projects, :uniq => true
	has_many :analytic_data
end