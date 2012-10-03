class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login_type, :name, :encrypted_password
  validates_format_of :name, :with => /^[^0-9`!@#\$%\^&*+_=]+$/
  has_and_belongs_to_many :projects
  before_save :default_values
  
  private

    def default_values
      self.login_type ||= 'regular_user'
    end

end
