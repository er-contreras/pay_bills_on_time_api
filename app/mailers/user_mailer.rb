class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'http://localhost:5000/login'

    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
