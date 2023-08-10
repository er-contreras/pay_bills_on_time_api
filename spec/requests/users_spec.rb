require 'rails_helper'
require 'support/factory_bot'

RSpec.describe UsersController, type: :controller do
  include JsonWebToken

  controller do
    def index
      render json: { message: 'Success' }
    end
  end

  describe 'authentication' do
    let(:user) { create(:user) }
    let(:valid_token) { jwt_encode(user_id: user.id) }
    let(:invalid_token) { 'this_is_not_a_valid_token' }

    context 'with a valid token' do
      before do
        request.headers['Authorization'] = "Bearer #{valid_token}"
        get :index
      end

      it 'sets the @current_user' do
        expect(controller.instance_variable_get(:@current_user)).to eq(user)
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with an invalid token' do
      before do
        request.headers['Authorization'] = "Bearer #{invalid_token}"
        controller.instance_variable_set(:@current_user, nil)
        get :index
      end

      it 'does not set the @current_user' do
        expect(controller.instance_variable_get(:@current_user)).to be_nil
      end

      it 'returns an unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'without a token' do
      before do
        get :index
      end

      it 'does not set the @current_user' do
        expect(controller.instance_variable_get(:@current_user)).to be_nil
      end

      it 'returns an unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
