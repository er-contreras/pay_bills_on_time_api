require 'rails_helper'

RSpec.describe "BillNotifications", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/bill_notification/create"
      expect(response).to have_http_status(:success)
    end
  end

end
