class User < ActiveRecord::Base
  attr_accessible :email, :login_type, :name, :password
  has_and_belongs_to_many :projects
end
