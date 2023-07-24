class EmailJob
  include Sidekiq::Job

  # bill_hour = Time.new(2023, 7, 22, 14, 30, 0)
  def perform(bill_hour)
    bill_hour = DateTime.strptime(bill_hour, '%H:%M')
    current_time = '21:50'

    if current_time < bill_hour
      # When using perform_at, the first argument should be the time when the job should be performed,
      # and the second argument should be the job arguments to be passed to the perform method.
      self.class.perform_at(bill_hour, nil)
    else
      self.class.perform_in(1.minute, current_time + 1.minute)
    end
    # Send email to the user
    # UserMailer.send_bill_notification(bill_date).deliver
    puts "Bill notification email has been sent to the user for #{bill_hour}"
  end
end
