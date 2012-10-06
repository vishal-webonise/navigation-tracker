class Project < ActiveRecord::Base
  attr_accessible :name, :domain_name, :domain_url
  self.per_page = 10

  validates :name, :domain_name, :domain_url, :presence => true
  validates :name, :length=> { :maximum => 50 }
  validates :name, :domain_name, :domain_url, :uniqueness => true
  validates_format_of :domain_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/i

	has_many :user_projects, :dependent => :destroy
	has_many :users, :through => :user_projects, :uniq => true
	has_many :analytic_data
end