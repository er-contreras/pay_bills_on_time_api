class UserMailer < ApplicationMailer
  def welcome_email(user_params)
    @user = user_params
    @url = 'http://localhost:5000/login'

    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  private

  def user_params
    @user = User.find(params[:user])
  end
end
