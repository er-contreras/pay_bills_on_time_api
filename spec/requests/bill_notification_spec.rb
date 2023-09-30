require 'rails_helper'

RSpec.describe BillNotificationController, type: :controller do
  describe 'POST #create' do
    let(:valid_params) { { bill_notification_data: { name: 'Bill Name', id: 1 } } }
    let(:invalid_params) { { bill_notification_data: { name: 'Non-existent Bill', id: 999 } } }

    context 'when a bill is found' do
      it 'toggles the bill_notification column and returns JSON response' do
        user = create(:user)
        bill = create(:bill, user:, id: 1) # Create a bill associated with the user
        bill_notification = create(:bill_notification, bill:) # Create a bill_notification associated with the bill

        expect(Bill).to receive(:find).with(valid_params[:bill_notification_data][:id]).and_return(bill)
        bill_notification.toggle(:notification)
        expect(bill_notification.notification).to eq(true)

        post :create, params: valid_params
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['message']).to eq('Bill notifications are now enabled for Bill Name')
      end
    end

    context 'when a bill is not found' do
      it 'returns a JSON response with a 404 status' do
        expect(Bill).to receive(:find).with(invalid_params[:bill_notification_data][:id]).and_return(nil)

        post :create, params: invalid_params
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['message']).to eq('User with email Non-existent Bill not found.')
      end
    end
  end
end
