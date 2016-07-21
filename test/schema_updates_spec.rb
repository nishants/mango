require './src/mango/schema_updates'
require 'json'

RSpec.describe SchemaUpdates do

  describe "SchemaUpdates" do
    it "should insert new field" do
      json = JSON.parse '{"data" : {"id": "one"}}'
      SchemaUpdates.insert("data.name", "hundered" , json)
      expect(json["data"]["name"]).to eq("hundered")
    end

  end

end