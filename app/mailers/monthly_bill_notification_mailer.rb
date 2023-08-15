class MonthlyBillNotificationMailer < ApplicationMailer
  def monthly_bill_notification(email, bill_date)
    @user_email = email
    @url = 'http://localhost:5000/login'

    mail(to: @user_email, subject: "Monthly bill notification #{bill_date}")
  end
end
