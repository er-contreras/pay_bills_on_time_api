require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe EmailJob, type: :job do
  describe '#perform' do
    it 'sends monthly bill notifications for bills with notification on the current date' do
      # Create a sample user and a bill with notification for the current date
      user = create(:user)
      bill = create(:bill, user: user, date: Date.today)
      create(:bill_notification, bill: bill, notification: true)

      # Ensure that the mailer is expected to receive :deliver_later
      allow(MonthlyBillNotificationMailer).to receive(:monthly_bill_notification).and_return(double('Mailer', deliver_later: true))

      # Perform the job
      EmailJob.new.perform

      # Expect the mailer to have been called once
      expect(MonthlyBillNotificationMailer).to have_received(:monthly_bill_notification).once.with(user.email, Date.today)
    end

    it 'does not send notifications for bills with notification turned off' do
      # Create a sample user and a bill without notification for the current date
      user = create(:user)
      bill = create(:bill, user: user, date: Date.today)
      create(:bill_notification, bill: bill, notification: false)

      # Ensure that the mailer is not expected to receive :deliver_later
      allow(MonthlyBillNotificationMailer).to receive(:monthly_bill_notification)

      # Perform the job
      EmailJob.new.perform

      # Expect the mailer to not have been called
      expect(MonthlyBillNotificationMailer).not_to have_received(:monthly_bill_notification)
    end
  end
end
