require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'welcome_email' do
    let(:user) do
      double('user', name: 'John', username: 'john', email: 'john@gmail.com', password: '123456')
    end

    let(:welcome_email) { UserMailer.welcome_email(user) }

    before do
      allow(User).to receive(:first).and_return(user)
    end

    it 'does not send an email initially' do
      expect(ActionMailer::Base.deliveries).to be_empty
    end

    it 'sends an email when deliver_now is called' do
      # Call the mailer method (deliver_now is already called on welcome_email)
      welcome_email.deliver_now

      # Check that one email has been sent after the mailer method call
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'sends the email to the correct recipient' do
      welcome_email.deliver_now

      # Verify the content of the email
      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eq(['john@gmail.com'])
    end

    it 'includes the correct subject in the email' do
      welcome_email.deliver_now

      # Verify the content of the email
      mail = ActionMailer::Base.deliveries.last
      expect(mail.subject).to eq('Welcome to My Awesome Site')
    end

    it 'includes the correct url in the email body' do
      welcome_email.deliver_now

      mail = ActionMailer::Base.deliveries.last
      html_body = mail.html_part.body.to_s
      expect(html_body).to include('http://localhost:5000/login')
    end
  end
end
