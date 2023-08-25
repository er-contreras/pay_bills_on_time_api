require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe EmailJob, type: :job do
  # include ActiveJob::TestHelper
  let(:email) { 'johndoe@gmail.com' }
  let(:date) { '24/07/2023' }

  describe '#perform' do
    it 'assert that jobs were pushed on to the queue' do
      expect { EmailJob.perform_async(email, date) }.to change(EmailJob.jobs, :size).by(1)
    end

    it 'perform method should be enqueue after receiving parameters' do
      EmailJob.perform_async(email, date)
      expect(EmailJob).to have_enqueued_sidekiq_job(email, date)
    end

    it 'execute all queued jobs by draining the queue' do
      EmailJob.perform_async(email, date)
      expect(EmailJob.jobs.size).to eq(1)
      Sidekiq::Worker.drain_all
      expect(EmailJob.jobs.size).to eq(0)
    end

    context 'sends notification email to the user' do
      before do
        travel_to Time.new(2023, 7, 24)
      end

      after do
        travel_back
      end

      it 'the day of the deadline' do
        EmailJob.perform_async(email, date)
        expect(EmailJob.jobs.size).to eq(1)

        Sidekiq::Worker.drain_all

        # Assert that the email was delivered
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(ActionMailer::Base.deliveries.last.to[0]).to eq(email)

        # Move time forward to the next month
        travel 1.month

        EmailJob.perform_async(email, date)
        expect(EmailJob.jobs.size).to eq(1)

        Sidekiq::Worker.drain_all

        # Assert that the email was delivered for the next month
        expect(ActionMailer::Base.deliveries.count).to eq(2)
        expect(ActionMailer::Base.deliveries.last.to[0]).to eq(email)

        # Continue this pattern for subsequent months if needed
        # ...

        # Reset the time after all tests
        travel_back
      end
    end
  end
end
