class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login_type, :first_name, :last_name, :encrypted_password
  validates :first_name, :last_name, :password, presence: true
  validates :password, length: { minimum: 6, maximum: 12 }
  has_and_belongs_to_many :projects
  before_save :default_values
  after_create :send_welcome_email
  
  private

    def default_values
      self.login_type ||= 'regular_user'
    end

    private

    def send_welcome_email
      UserMailer.welcome_email(self).deliver
    end

end
