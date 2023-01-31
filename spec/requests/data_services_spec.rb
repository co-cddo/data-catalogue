require 'rails_helper'

RSpec.describe "DataServices", type: :request do
  describe "GET /data_service" do
    it "returns data_services" do
      get data_services_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /data_service" do
    let(:data_service) { create(:data_service) }

    it "returns data_services" do
      get data_service_path(data_service)
      expect(response).to have_http_status(:ok)
    end
  end
end
