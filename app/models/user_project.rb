class UserProject < ActiveRecord::Base
  attr_accessible :is_owner, :project_id, :user_id
  #belongs_to :user
  #belongs_to :project, :dependent => :destroy
  belongs_to :user
  belongs_to :project
  validates_uniqueness_of :user_id, :scope => [:project_id]
end