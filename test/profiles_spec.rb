require './src/mango/profiles'
require 'tempfile'
require 'rspec'

RSpec.describe Mango::Profiles do

  describe "Profiles" do
    def absolute_path path
      return Pathname.new(path).realpath.to_s
    end
    before(:each) do
      @TEST_PROFILES_PATH  = "/Users/dawn/Documents/projects/schemer/test/test-profiles"
      @profiles_home = Tempfile.new("#{Random.new(212).rand()}").path()

      FileUtils.rm_rf(@profiles_home)
      FileUtils::mkdir_p @profiles_home
      FileUtils.copy_entry @TEST_PROFILES_PATH, @profiles_home

      @Profiles       = Mango::Profiles.load(@profiles_home)
      @ace_name       = "Ace"
      @slot_name      = "Sloth"

      @ace_id         = "ace-user"
      @sloth_id       = "sloth-user"

      @ace_dir        = absolute_path "#{@profiles_home}/profile-ace"
      @sloth_dir      = absolute_path "#{@profiles_home}/profile-sloth"

      @ace_desc       = "Represent the profile of an ace user"
      @slot_desc      = "Represent the profile of a sloth user"
    end

    it "should read all profiles.json and return summary" do
      profiles = @Profiles.all()
      expect(profiles.length).to eq(2);

      names = profiles.map{|profile| profile["name"]}
      expect(names.include?(@ace_name)).to eq(true)
      expect(names.include?(@slot_name)).to eq(true)


      descriptions = profiles.map{|profile| profile["description"]}
      expect(descriptions.include?(@ace_desc)).to eq(true)
      expect(descriptions.include?(@slot_desc)).to eq(true)

      descriptions = profiles.map{|profile| profile["dir"]}
      expect(descriptions.include?(@ace_dir)).to eq(true)
      expect(descriptions.include?(@sloth_dir)).to eq(true)
    end

    it "should find profile by name" do
      profile = @Profiles.find("Ace")
      expect(profile["name"]).to eq(@ace_name)
      expect(profile["description"]).to eq(@ace_desc)
    end

    it "Should get profile json files" do
      json = @Profiles.find("Ace")["home"].content
      expect(json["data"]["user"]["id"]).to eq(@ace_id)
    end

    it "Should update profile json files" do
      home         = @Profiles.find("Ace")["home"]
      home.content["data"]["user"]["id"] = "updated"
      home.save

      actual_content = JSON.parse(File.read("#{@profiles_home}/profile-ace/home.json"))
      expect(actual_content["data"]["user"]["id"]).to eq("updated")
    end

    it "Should update json files in all profiles" do
      content       = JSON.parse('{"data" : {"Message" : "HellO"}}');

      @Profiles.updateAllFiles("home", content)

      content_ace   = JSON.parse(File.read("#{@profiles_home}/profile-ace/home.json"))
      content_sloth = JSON.parse(File.read("#{@profiles_home}/profile-sloth/home.json"))

      expect(content_sloth).to eq(content)
      expect(content_ace).to eq(content)
    end

    describe "Schema Update : update json schema in all profiles" do
      before(:all) do
        updates  = [{"field" => "", "renameTo" => ""},
                    {"insert" => "field.field", "value" => "some-value"},
                    {"remove" => "missingField"}];

      end

      it "Should insert fields to schema" do
        @Profiles.updateSchema("home", [{"insert" => "data.user.user-id", "value" => "user-id-value"}])

        content_ace   = JSON.parse(File.read("#{@profiles_home}/profile-ace/home.json"))
        content_sloth = JSON.parse(File.read("#{@profiles_home}/profile-sloth/home.json"))

        expect(content_sloth["data"]["user"]["user-id"]).to eq("user-id-value")
        expect(content_ace["data"]["user"]["user-id"]).to eq("user-id-value")
      end

      it "Should delete fields from schema" do
        @Profiles.updateSchema("home", [{"remove" => "data.user.id"}])

        content_ace   = JSON.parse(File.read("#{@profiles_home}/profile-ace/home.json"))
        content_sloth = JSON.parse(File.read("#{@profiles_home}/profile-sloth/home.json"))

        expect(content_sloth["data"]["user"]["id"]).to eq(nil)
        expect(content_ace["data"]["user"]["id"]).to eq(nil)
      end

      it "Should delete fields from schema" do
        @Profiles.updateSchema("home", [{"field" => "data.user.id", "renameTo" => "user-id"}])

        content_ace   = JSON.parse(File.read("#{@profiles_home}/profile-ace/home.json"))
        content_sloth = JSON.parse(File.read("#{@profiles_home}/profile-sloth/home.json"))

        expect(content_sloth["data"]["user"]["user-id"]).to eq(@sloth_id)
        expect(content_ace["data"]["user"]["user-id"]).to eq(@ace_id)

        expect(content_sloth["data"]["user"]["id"]).to eq(nil)
        expect(content_ace["data"]["user"]["id"]).to eq(nil)
      end

    end

  end

end