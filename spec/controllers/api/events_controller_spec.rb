require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  describe "GET index" do
    before(:each) do
      3.times {create(:event, date: DateTime.new(2014, 2, 28, 1, 1))}
      create(:event, date: DateTime.new(2014, 2, 28, 1, 3))
      create(:event, date: Faker::Time.forward(5))
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

    describe "query params" do
      it "filters by from date" do
        get :index, format: :json, from: '2015-02-28T13:01Z'
        expect(JSON.parse(response.body).length).to eq(1)
      end

      it "filters by to date" do
        get :index, format: :json, to: '2014-02-28T13:01Z'
        expect(JSON.parse(response.body).length).to eq(4)
      end

      it 'filters with both from and to date' do
        get :index, format: :json, from: '2014-02-28T00:59Z', to: '2014-02-28T01:02Z'
        expect(JSON.parse(response.body).length).to eq(3)
      end
    end
  end

  describe "POST create" do
    it "creates a valid event" do
      get :index, format: :json
      expect(JSON.parse(response.body).length).to eq(0)
      post :create, format: :json, date: "2014-02-28T13:02Z", user: "Alice", type: "highfive", otheruser: "Bob"
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")
      get :index, format: :json
      expect(JSON.parse(response.body).length).to eq(1)
    end

    it "throws an error for an invalid event" do
      post :create, format: :json, date: "2014-02-28T13:02Z", type: "highfive", otheruser: "Bob"
      expect(response.status).to eq(422)
      get :index, format: :json
      expect(JSON.parse(response.body).length).to eq(0)
    end
  end
end
