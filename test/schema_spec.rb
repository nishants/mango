require './src/schema'

RSpec.describe Schema do
  describe "#create" do
    it "creates a schema" do
      Users = Schema.create({:name => "Users"})
      Users.collections.add({:name => "home",       :path => "home.json"});
      Users.collections.add({:name => "companies",  :path => "companies/all.json"});

      user_one = Users.load("/Users/dawn/Documents/projects/schemer/samples/users/1011");
      expect(user_one.home["data"]["message"]).to eq("hello");
    end
  end
end