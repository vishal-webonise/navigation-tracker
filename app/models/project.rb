class Project < ActiveRecord::Base
  attr_accessible :name, :domain_name, :domain_url

  validates :name ,:presence => { :message => "Project name can't be blank" }
  validates :name, :length => { :maximum => 50,
                               :too_long => "maximum %{count} characters are the allowed" }
  validates :domain_url ,:presence => { :message => "Domain URL can't be blank" }

  validates :name, :uniqueness => { :message => "Project name should be unique" }
  validates :domain_url, :uniqueness => { :message => "Domain URL should be unique" }

  validates_format_of :domain_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/i, :message => "Enter a valid domain URL"

	has_many :user_projects, :dependent => :destroy
	has_many :users, :through => :user_projects, :uniq => true
	has_many :analytic_data
end