# Preview all emails at http://localhost:3000/rails/mailers/user
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    user = params[:user]
    UserMailer.with(user: user).welcome_email
  end
end
