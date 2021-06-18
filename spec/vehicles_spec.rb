require "rails_helper"

describe "Electric Vehicle API", type: :request do
  describe "GET /vehicles" do
    before do
      FactoryBot.create(:vehicle, make: "BMW", model: "i3", year: 2020)
      FactoryBot.create(:vehicle, make: "Mercedes-Benz", model: "A Class Hatchback", year: 2021)
    end

    it "returns all vehicles" do
      get "/api/v1/vehicles"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it "returns a vehicle" do
      vehicle = FactoryBot.create(:vehicle, make: "BMW", model: "i3", year: 2020)

      get "/api/v1/vehicles/#{vehicle.id}"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["model"]).to eq("i3")
    end
  end

  describe "POST /vehicles" do
    it "creates a new vehicle" do
      expect {
        post "/api/v1/vehicles", params: { vehicle: { make: "Volkswagen", model: "e-Golf", year: 2022 } }
      }.to change { Vehicle.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT /vehicles/:id" do
    it "updates a vehicle" do
      vehicle = FactoryBot.create(:vehicle, make: "BMW", model: "i3", year: 2020)

      put "/api/v1/vehicles/#{vehicle.id}", params: { vehicle: { year: 2050 } }

      expect(response).to have_http_status(:ok)
      expect(Vehicle.find(vehicle.id).year).to eq(2050)
    end
  end

  describe "DELETE /vehicles/:id" do
    let!(:vehicle) { FactoryBot.create(:vehicle, make: "BMW", model: "i3", year: 2015) }

    it "deletes a vehicle" do
      expect {
        delete "/api/v1/vehicles/#{vehicle.id}"
      }.to change { Vehicle.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
