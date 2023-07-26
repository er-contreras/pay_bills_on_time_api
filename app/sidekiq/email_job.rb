class EmailJob
  include Sidekiq::Job

  def perform(bill_date)
    day, month, year = bill_date.split('/').map(&:to_i)
    date = Date.new(year, day, month)
    date_plus_one = date + 1
    date_plus_one_str = date_plus_one.strftime('%d/%m/%y')

    self.class.perform_in(1.day, date_plus_one_str)

    UserMailer.with(User.first).welcome_email.deliver_now

    puts "Bill notification email has been sent to the user no time: #{date_plus_one_str}"
  end
end
