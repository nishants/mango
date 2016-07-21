require './src/mango/schema_updates'
require 'json'

RSpec.describe SchemaUpdates do

  describe "SchemaUpdates" do
    it "should insert new field" do
      json = JSON.parse '{"data" : {"id": "one"}}'
      SchemaUpdates.insert("data.name", "hundered" , json)
      expect(json["data"]["name"]).to eq("hundered")
    end

    it "should ignore insert if parent object not found" do
      json = JSON.parse '{"data" : {"id": "one"}}'
      SchemaUpdates.insert("data.bar.body", "hundered" , json)
      expect(json).to eq(JSON.parse '{"data" : {"id": "one"}}')
    end

  end

end