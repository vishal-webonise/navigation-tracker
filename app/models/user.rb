class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :validatable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login_type, :first_name, :last_name, :encrypted_password, :current_password

  #validates :first_name, :email, presence: true
  validates :first_name, :presence => { :message => "User first name can't be blank" }
  validates :last_name, :presence => { :message => "User last name can't be blank" }
  validates :email, :presence => { :message => "Email can't be blank" }
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Enter a valid email address"
  validates :email, :uniqueness => { :message => "Email should be unique" }
  validates :password, :presence => { :message => "Password can't be blank" }
  validates :password, :confirmation => { :message => "Passwords do not match" }
  validates_confirmation_of :password
  if :password.present? do
    validates :password, length: { minimum: 6, maximum: 15 }, :message => "Enter password between 6 to 15 characters"
    validates_format_of :password, :with => /^[a-zA-Z0-9]+$/, :message => "Enter password in alphanumeric format"
  end
  end

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
