require './src/mango/profiles'
require 'fileutils'

RSpec.describe Profiles do

  describe "read schema" do
    before(:all) do
      @profiles_home = "/Users/dawn/Documents/projects/schemer/samples/profiles"
      @Profiles = Profiles.load(@profiles_home)
      @ace_name  = "Ace"
      @slot_name = "Sloth"
      @ace_desc  = "Represent the profile of an ace user"
      @slot_desc = "Represent the profile of a sloth user"
    end

    it "Should read all profiles.json and return summary" do
      profiles = @Profiles.all()
      expect(profiles.length).to eq(2);

      names = profiles.map{|profile| profile["name"]}
      expect(names.include?(@ace_name)).to eq(true)
      expect(names.include?(@slot_name)).to eq(true)


      descriptions = profiles.map{|profile| profile["description"]}
      expect(descriptions.include?(@ace_desc)).to eq(true)
      expect(descriptions.include?(@slot_desc)).to eq(true)
    end

  end

end