require 'rails_helper'

RSpec.describe Api::SummaryController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }

  describe "GET index" do
    before(:each) do
      3.times {create(:event, date: DateTime.new(2014, 2, 28, 1, 1), type_of: "comment")}
      create(:event, date: DateTime.new(2014, 2, 28, 1, 3), type_of: "highfive")
      create(:event, date: Faker::Time.forward(5), type_of: "enter")
    end

    it "returns counts for all records" do
      get :index, format: :json
      counts = JSON.parse(response.body)
      expect(counts["enters"]).to eq(1)
      expect(counts["comments"]).to eq(3)
      expect(counts["highfives"]).to eq(1)
    end

    it "returns accurate counts with 'to' params" do
      get :index, format: :json, to: '2014-02-28T01:02Z'
      counts = JSON.parse(response.body)
      expect(counts["enters"]).to eq(0)
      expect(counts["comments"]).to eq(3)
      expect(counts["highfives"]).to eq(0)
    end

    it "returns accurate counts with 'from' params" do
      get :index, format: :json, from: '2014-02-28T01:02Z'
      counts = JSON.parse(response.body)
      expect(counts["enters"]).to eq(1)
      expect(counts["comments"]).to eq(0)
      expect(counts["highfives"]).to eq(1)
    end

    it "creates intervals properly" do
      get :index, format: :json, to: '2014-02-28T01:02Z', by: "minute"
      counts = JSON.parse(response.body)
      expect(counts[0]["date"]).to eq("2014-02-28T01:01:00.000Z")
      expect(counts[0]["comments"]).to eq(3)
      expect(counts[1]["date"]).to eq("2014-02-28T01:02:00.000Z")
      expect(counts[1]["comments"]).to eq(0)
    end
  end
end
