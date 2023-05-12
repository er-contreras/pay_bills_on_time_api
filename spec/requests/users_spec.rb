require 'rails_helper'

RSpec.describe "Users", type: :controller do
  before(:each) do
    @controller = UsersController.new
  end

  describe "GET /index" do
    it "returns http success" do
      get :index
      expect(response).to eq(200)
    end
  end
end
