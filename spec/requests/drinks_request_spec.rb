require 'rails_helper'

RSpec.describe "Drinks", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/drinks/index"
      expect(response).to have_http_status(:success)
    end
  end

end
