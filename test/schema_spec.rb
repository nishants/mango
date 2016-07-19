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

      user_one = @Users.load("/Users/dawn/Documents/projects/schemer/samples/users/2022");
      expect(user_one.home["data"]["message"]).to eq("hello back");
      expect(user_one.companies["data"][0]["name"]).to eq("abc");

    end
  end

  describe "update collections field in file" do
    before(:all) do
      @dir    = "/Users/dawn/Documents/projects/schemer/samples/temp"
      @schema = "/#{@dir}/schema.json"

      FileUtils::mkdir_p @dir
      FileUtils.copy_entry "/Users/dawn/Documents/projects/schemer/samples/users", @dir

      @Users  = Schema.create({:file => @schema})
    end

    after(:all) do
      FileUtils.rm_rf(@dir)
    end

    it "renames collection field" do
      @Users.update({
          :path       => @dir,
          :collection => "home",
          :field      => "data.message",
          :rename_to  => "status"
      });
      new_json = JSON.parse(File.read("/Users/dawn/Documents/projects/schemer/samples/temp/1011/home.json"))

      expect(new_json["data"]["status"]).to eq("hello");
      expect(new_json["data"].key?("message")).to eq(false);

      new_json = JSON.parse(File.read("/Users/dawn/Documents/projects/schemer/samples/temp/2022/home.json"))

      expect(new_json["data"]["status"]).to eq("hello back");
      expect(new_json["data"].key?("message")).to eq(false);
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