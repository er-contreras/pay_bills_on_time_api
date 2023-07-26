class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = 'http://localhost:5000/login'

    if @user.nil?
      mail(to: User.first.email, subject: 'Welcome to My Awesome Site')
    else
      mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
  end
end
