class UserProject < ActiveRecord::Base
  attr_accessible :is_owner, :project_id, :user_id
  belongs_to :user
  belongs_to :project
end