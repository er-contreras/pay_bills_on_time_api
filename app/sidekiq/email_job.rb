class EmailJob
  include Sidekiq::Job

  sidekiq_options retry: false

  def perform(email, bill_date)
    day, month, year = bill_date.split('/').map(&:to_i)
    date = Date.new(year, month, day)
    date_plus_one = date + 1
    date_plus_one_str = date_plus_one.strftime('%d/%m/%y')

    self.class.perform_in(1.day, email, date_plus_one_str)

    MonthlyBillNotificationMailer.monthly_bill_notification(email, date_plus_one_str).deliver_now

    puts "Bill notification email has been sent to the user: #{date_plus_one_str}"
  end
end
