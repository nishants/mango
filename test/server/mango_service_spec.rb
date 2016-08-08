require './src/server/mango_service'
require 'tempfile'
require 'rspec'
require './test/test_helper'

RSpec.describe Mango::MangoService do

  describe "MangoService" do

    def absolute_path path
      return Pathname.new(path).realpath.to_s
    end

    before(:each) do
      @test_helper = Mango::TestHelper.new
      @config_file = "#{@test_helper.test_data}/sample-config-file.json"

      config = JSON.parse(File.read(@config_file))
      @sample_project_path = "#{@test_helper.test_data}/samples/profiles"
      config["projects"][0]["path"] = @sample_project_path
      @test_helper.save_json(@config_file, config)

      @empty_project_path = "#{@test_helper.test_data}/new-project";
      @existing_project = @test_helper.read_json(@config_file)["projects"][0]
      @service = Mango::MangoService.new(@config_file)
    end

    it "should return all projects" do
      expect(@service.projects).to eq([{"name"=>"sample", "path"=>@sample_project_path}])
    end

    it "should return project by name" do
      expect(@service.find("not-exists").nil?).to eq(true)
      expect(@service.find("sample")["path"]).to eq(@sample_project_path)
    end

    it "should add new project" do
      project_name = "project-name"
      project_path = @empty_project_path
      description  = ""

      @service.import(project_name, @empty_project_path, description)
      expect(@service.projects).to eq([@existing_project, {"name" => project_name, "path" => project_path,"description"=>""}])

      contracts_paths = @service.contracts(project_name).map{|contract| contract["path"]}
      expected_contract_paths = ["home.json", "companies/all.json"]

      expect(contracts_paths).to match_array(expected_contract_paths)
    end

    it "should update name and description for a project" do
      project_name  = @service.find("sample")["name"];
      update = {
          "name" => "new-name",
          "description" => "new-description"
      }

      @service.update(project_name, update)

      updated = @service.find("new-name")
      expect(updated["description"]).to eq("new-description")
      expect(@service.find("sample")).to eq(nil)
    end

    it "should delete a project" do
      project_name  = @service.find("sample")["name"];
      @service.remove(project_name)
      expect(@service.find(project_name)).to eq(nil)
    end

    it "should get project profiles" do
      expected_profiles = [
          {"id" => "profile-sloth"   ,"name" => "Sloth", "description" => "Represent the profile of a sloth user"},
          {"id" => "profile-ace" ,"name" => "Ace",   "description" => "Represent the profile of an ace user"},
          {"id" => "no-profile"    ,"name" => "untitled",      "description" => ""},
          {"id"=>"no-contracts-profile", "name"=>"untitled", "description"=>""}
      ]
      profiles  = @service.profiles_of("sample")
      expect(profiles).to match_array(expected_profiles)
    end


    it "should update name and description for a profile in a project" do
      params   = {"name" => "new-profile-name", "description" => "new-profile-desc"}
      @service.update_profile("sample", "no-profile", params)
      updated = @service.find_profile("sample", "no-profile").to_json

      expect(updated["name"]).to eq("new-profile-name")
      expect(updated["description"]).to eq("new-profile-desc")
    end

    it "should get contracts from a profile" do
      profile  = @service.profile_contracts("sample", "no-profile")
      expected_contracts = [{"name" => "companies", "present" => true},
                            {"name" => "home"     , "present" => true}]
      expect(profile["contracts"]).to match_array(expected_contracts)
    end

    it "should get a contract file" do
      contract_file  = @service.contract_file("sample", "profile-ace", "companies")
      expected = {"data" => {"companies" => [{"name" => "ABC"},{"name" => "XYZ"}]}}
      expect(contract_file).to eq(expected)
    end

    it "should save a contract file" do
      expected = {"data" => "about-to-replace-contents"}
      @service.save_contract_file("sample", "profile-ace", "companies", expected)
      expect(@service.contract_file("sample", "profile-ace", "companies")).to eq(expected)
    end
    
    it "should update contract schema" do
      updates  = [{"field" => "data.companies", "renameTo" => "my-companies"},
                  {"insert" => "data.status"  , "value"    => "inserted"}]

      expected_profile_ace = {
          "data" => {
              "status"        =>"inserted",
              "my-companies"  => [{"name" => "ABC"},{"name" => "XYZ"}]
      }}

      expected_profile_sloth = {
          "data" => {
              "status"        =>"inserted",
              "my-companies"  => [{"name" => "246"},{"name" => "135"}]
      }}

      @service.update_contract_schema("sample", "companies", updates)

      actual_profile_ace          =  @service.contract_file("sample", "profile-ace",          "companies")
      actual_profiles_sloth       = @service.contract_file("sample" , "profile-sloth",        "companies")
      actual_profile_missing_file = @service.contract_file("sample" , "no-contracts-profile", "companies")

      expect(actual_profile_ace["data"]["companies"]).to be_nil
      expect(actual_profile_ace).to include(expected_profile_ace)
      expect(actual_profiles_sloth).to include(expected_profile_sloth)
      expect(actual_profile_missing_file).to be_nil
    end

  end

end