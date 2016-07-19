require './src/schema'
require 'fileutils'

RSpec.describe Schema do
  describe "create schema from file" do
    before(:all) do
      @Users = Schema.create({:file => "/Users/dawn/Documents/projects/schemer/samples/users/schema.json"})
    end

    it "creates a schema" do
      user_one = @Users.load("/Users/dawn/Documents/projects/schemer/samples/users/1011");
      expect(user_one.home["data"]["message"]).to eq("hello");
      expect(user_one.companies["data"][0]["name"]).to eq("xyz");
    end
  end

  describe "update collections field in file" do
    before(:all) do
      @dir   = "/Users/dawn/Documents/projects/schemer/samples/temp"
      FileUtils::mkdir_p @dir
      FileUtils.copy_entry "/Users/dawn/Documents/projects/schemer/samples/users", @dir
      @schema = "/#{@dir}/schema.json"
      @Users  = Schema.create({:file => @schema})
    end

    after(:all) do
      # File.delete @dir
    end

    it "rename collection field" do
      @Users.update({
          :collection => "home",
          :field      => "data.message",
          :rename_to  => "status"
      });

    end
  end


  describe "create schema from parameter" do
    before(:all) do
      @Users = Schema.create({:definition => {
          "name" => "Users",
          "collections" => [
              {"name" => "home",      "path"=> "/home.json"},
              {"name" => "companies", "path" => "/companies/all.json"}
          ]
      }})
    end

    it "creates a schema" do
      user_one = @Users.load("/Users/dawn/Documents/projects/schemer/samples/users/1011");
      expect(user_one.home["data"]["message"]).to eq("hello");
      expect(user_one.companies["data"][0]["name"]).to eq("xyz");
    end
  end

end