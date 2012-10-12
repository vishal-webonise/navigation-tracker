class UserMailer < ActionMailer::Base
  default from: "admin@analytics.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Thank You for Registering to Analytics")
  end

  def change_user_details_by_admin_email(user)
    @user = user
    mail(:to => user.email, :subject => "Analytics Super Admin has updated your Information")
  end
end
