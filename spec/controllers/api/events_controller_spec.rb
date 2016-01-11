require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  describe "GET index" do
    before(:each) do
      5.times {create(:event)}
      get :index, format: :json
    end

    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end

    it "returns JSON data" do
      expect(response.content_type).to eq("application/json")
    end

    it "fetches all of the events" do
      expect(JSON.parse(response.body).length).to eq(5)
    end
  end
end
