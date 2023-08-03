class UserMailer < ApplicationMailer
  def welcome_email(find_user)
    @user = find_user
    @url = 'http://localhost:5000/login'

    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
