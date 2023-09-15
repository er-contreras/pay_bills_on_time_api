class EmailJob
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform
    @current_date = Date.today
    bills_notifications = eligible_bill_notifications

    bills_notifications.each do |bill_notification|
      send_notification_email(bill_notification)
    end
  end

  private

  def eligible_bill_notifications
    BillNotification.where(notification: true).includes(bill: :user)
      .select { |bn| bn.bill.date.to_date == @current_date }
  end

  def send_notification_email(bill_notification)
    user = bill_notification.bill.user
    MonthlyBillNotificationMailer.monthly_bill_notification(user.email, @current_date).deliver_later
  end
end
