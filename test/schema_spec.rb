require './src/schema'

RSpec.describe Schema do
  describe "#create" do
    it "creates a schema" do
      Users = Schema.create({:name => "Users",      :path => "../samples/users"})
      Users.collections.add({:name => "home",       :path => "home.json"});
      Users.collections.add({:name => "companies",  :path => "companies/all.json"});

      expect(Users).to eq(Users)
    end
  end
end