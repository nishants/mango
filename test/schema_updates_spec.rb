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

    it "should ignore remove if parent object not found" do
      json = JSON.parse '{"data" : {"id": "one"}}'
      SchemaUpdates.remove("data.bar.body" , json)
      expect(json).to eq(JSON.parse '{"data" : {"id": "one"}}')
    end

    it "should ignore rename if parent object not found" do
      json = JSON.parse '{"data" : {"id": "one"}}'
      SchemaUpdates.rename("data.bar.body.foo", "boddy" , json)
      expect(json).to eq(JSON.parse '{"data" : {"id": "one"}}')
    end

    it "should rename inside array" do
      json = JSON.parse '{"data": [{"id" : "me", "name": "jugnu", "list": [{"inner" : "one"},{"inner" : "two"}]}]}'
      SchemaUpdates.rename("data[].list[].inner", "inner-renamed" , json)
      expect(json).to eq(JSON.parse '{"data": [{"id" : "me", "name": "jugnu", "list": [{"inner-renamed" : "one"},{"inner-renamed" : "two"}]}]}')
    end

    it "should insert inside array" do
      json = JSON.parse '{"data": [{"id" : "me", "name": "jugnu", "list": [{"inner" : "one"},{"inner" : "two"}]}]}'
      SchemaUpdates.insert("data[].list[].another-inner", "inserted-values" , json)
      expect(json).to eq(JSON.parse '{"data": [{"id" : "me", "name": "jugnu", "list": [{"inner" : "one", "another-inner": "inserted-values"},{"inner" : "two", "another-inner": "inserted-values"}]}]}')
    end

  end

end