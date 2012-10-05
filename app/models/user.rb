class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login_type, :first_name, :last_name, :encrypted_password

  validates :first_name, :last_name, :email, :password, presence: true
  validates :password, length: { minimum: 6, maximum: 12 }
  validates_format_of :password, :with => /^[a-zA-Z0-9]+$/
  validates_uniqueness_of :email, :on => :create, :message => "This e-mail is already taken"
  
  has_many :user_projects, :dependent => :destroy
  has_many :projects, :through => :user_projects, :uniq => true
  
  before_save :default_values
  after_create :send_welcome_email

  private

    def default_values
      self.login_type ||= 'regular_user'
    end

    def send_welcome_email
      UserMailer.welcome_email(self).deliver
    end

end