class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login_type, :first_name, :last_name, :encrypted_password
  validates :first_name, :last_name, :password, presence: true
  validates :password, length: { minimum: 6, maximum: 12 }
  has_and_belongs_to_many :projects
  before_save :default_values
  
  private

    def default_values
      self.login_type ||= 'regular_user'
    end

end
