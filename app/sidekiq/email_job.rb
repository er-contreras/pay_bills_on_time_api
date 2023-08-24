class EmailJob
  include Sidekiq::Job

  sidekiq_options retry: false

  def perform(email, bill_date)
    MonthlyBillNotificationMailer.monthly_bill_notification(email, bill_date).deliver_later

    puts "Bill notification email will be sent to the user on: #{bill_date}"
  end
end
