class UserMailer < ActionMailer::Base
  default from: "admin@analytics.com"

  def welcome_email(user)
    @user = user
    mail(:to => user.email, :subject => "Thank You for Registering to Analytics")
  end
end
