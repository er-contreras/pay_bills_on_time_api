class EmailJob
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform
    current_date = Date.today
    bills_notifications = BillNotification.where(notification: true).includes(:bill)

    bills_notifications.each do |bill_notification|
      user = bill_notification.bill.user
      date = bill_notification.bill.date

      if date.to_date == current_date
        MonthlyBillNotificationMailer.monthly_bill_notification(user.email, current_date).deliver_later
      end
    end
  end
end
