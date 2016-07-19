require './src/schema'

RSpec.describe Schema do
  describe "#create" do
    before(:all) do
      @Users = Schema.create({:file => "/Users/dawn/Documents/projects/schemer/samples/users/schema.json"})
    end

    it "creates a schema" do
      user_one = @Users.load("/Users/dawn/Documents/projects/schemer/samples/users/1011");
      expect(user_one.home["data"]["message"]).to eq("hello");
      expect(user_one.companies["data"][0]["name"]).to eq("xyz");
    end
  end
end