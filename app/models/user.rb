class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :validatable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login_type, :first_name, :last_name, :encrypted_password, :current_password

  validates :first_name, :last_name, :email, presence: true
  if :password.present? do
    validates :password
    validates :password, length: { minimum: 6, maximum: 15 }
    validates_format_of :password, :with => /^[a-zA-Z0-9]+$/
  end
  end

  validates_uniqueness_of :email, :on => :create

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
