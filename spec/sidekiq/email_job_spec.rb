require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe EmailJob, type: :job do
  # include ActiveJob::TestHelper
  let(:email) { 'johndoe@gmail.com' }
  let(:date) { '24/07/2023' }
  let(:date2) { '25/07/2023' }

  describe '#perform' do
    it 'assert that jobs were pushed on to the queue' do
      expect { EmailJob.perform_async(email, date) }.to change(EmailJob.jobs, :size).by(1)
    end

    it 'execute all queued jobs by draining the queue' do
      EmailJob.perform_async(email, date)
      EmailJob.perform_async(email, date2)
      expect(EmailJob.jobs.size).to eq(2)
      EmailJob.clear
      expect(EmailJob.jobs.size).to eq(0)
    end

    it 'perform method should be enqueue after receiving parameter' do
      EmailJob.perform_async(email, date)
      expect(EmailJob).to have_enqueued_sidekiq_job(email, date)
    end

    it 'sends notification email to the user every month based on the bill deadline date'
  end
end
